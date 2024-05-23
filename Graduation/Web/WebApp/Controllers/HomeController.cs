using WebApp.Models;
using WebApp.Data;
using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Authentication.Cookies;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Localization;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using Microsoft.IdentityModel.Tokens;
using Serilog;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Globalization;
using System.IdentityModel.Tokens.Jwt;
using System.Linq;
using System.Security.Claims;
using System.Text;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Cryptography.KeyDerivation;

namespace WebApp.Controllers
{
    public class HomeController : Controller
    {
        private readonly ILogger<HomeController> _logger;
        private readonly IConfiguration _config;
        private readonly IOptions<ApiEndpoint> _settings;
        private readonly WebAppContext _context;

        public HomeController(ILogger<HomeController> logger,
                             IConfiguration config,
                             IOptions<ApiEndpoint> settings,
                             WebAppContext context)
        {
            _logger = logger;
            _config = config;
            _settings = settings;
            _context = context;
        }

        public IActionResult AboutUs()
        {
            string key = "IIN";
            string value = "880111300392";

            CookieOptions options = new CookieOptions
            {
                Expires = DateTime.Now.AddDays(1)
            };

            Response.Cookies.Append(key, value);
            Response.Cookies.Append("key_2", value);
            Response.Cookies.Append("key_3", value);

            return View();
        }

        public IActionResult Index(string culture = "")
        {
            var data0 = _settings.Value.Url;
            var data = _config.GetSection("Middleware").GetSection("EnableContentMiddleware").Value;
            var data2 = _config.GetSection("Middleware").GetValue<bool>("EnableContentMiddleware");
            var data3 = _config.GetSection("Middleware:EnableContentMiddleware").Value;

            if (!string.IsNullOrEmpty(culture))
            {
                CultureInfo.CurrentCulture = new CultureInfo(culture);
                CultureInfo.CurrentUICulture = new CultureInfo(culture);
            }

            HttpContext.Session.SetString("product", "Auto");
            string value = HttpContext.Session.GetString("product");

            _logger.LogInformation("testInfo");
            _logger.LogError("testInfo");

            string email = "ok@ok.kz";
            _logger.LogWarning("testInfo: {email} - {logTime}", email, DateTime.Now);

            return View();
        }

        public string GetCulture(string code)
        {
            if (!string.IsNullOrWhiteSpace(code))
            {
                CultureInfo.CurrentCulture = new CultureInfo(code);
                CultureInfo.CurrentUICulture = new CultureInfo(code);
            }
            return "";
        }

        public IActionResult Privacy()
        {
            return View();
        }

        [Authorize]
        public IActionResult About_us()
        {
            string key = "IIN";
            string value = "880111300392";

            CookieOptions options = new CookieOptions
            {
                Expires = DateTime.Now.AddDays(1)
            };

            Response.Cookies.Append(key, value);
            Response.Cookies.Append("key_2", value);
            Response.Cookies.Append("key_3", value);

            return View();
        }

        public IActionResult Pages()
        {
            return View();
        }

        public IActionResult Services()
        {
            return View();
        }

        public IActionResult Contact_us()
        {
            return View();
        }

        public IActionResult Blog()
        {
            return View();
        }

        public IActionResult Login(string ReturnUrl)
        {
            ViewBag.ReturnUrl = ReturnUrl;
            return View();
        }

        [HttpPost]
        public IActionResult Login(string username, string password, int phoneNumber, string ReturnUrl)
        {
            var user = _context.Users.SingleOrDefault(u => u.Username == username);

            if (user != null && VerifyPassword(password, user.PasswordHash, user.PasswordSalt))
            {
                var claims = new List<Claim>
                {
                    new Claim(ClaimTypes.Name, username)
                };
                var claimsIdentity = new ClaimsIdentity(claims, "Login");

                HttpContext.SignInAsync(CookieAuthenticationDefaults.AuthenticationScheme, new ClaimsPrincipal(claimsIdentity));

                var tokenString = GenerateJWT(username);
                return Ok(new { token = tokenString });
            }

            return View();
        }

        [HttpPost]
        public IActionResult Register(string username, string password)
        {
            var salt = GenerateSalt();
            var hash = HashPassword(password, salt);

            var user = new User { Username = username, PasswordHash = hash, PasswordSalt = salt };
            _context.Users.Add(user);
            _context.SaveChanges();

            var claims = new List<Claim>
            {
                new Claim(ClaimTypes.Name, username)
            };
            var claimsIdentity = new ClaimsIdentity(claims, "Login");

            HttpContext.SignInAsync(CookieAuthenticationDefaults.AuthenticationScheme, new ClaimsPrincipal(claimsIdentity));

            var tokenString = GenerateJWT(username);
            return Ok(new { token = tokenString });
        }

        private string GenerateJWT(string username)
        {
            var securityKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(_config["Jwt:Key"]));
            var credentials = new SigningCredentials(securityKey, SecurityAlgorithms.HmacSha256);

            var claims = new[]
            {
                new Claim(JwtRegisteredClaimNames.Sub, username),
                new Claim(JwtRegisteredClaimNames.Jti, Guid.NewGuid().ToString())
            };

            var token = new JwtSecurityToken(
                issuer: _config["Jwt:Issuer"],
                audience: _config["Jwt:Audience"],
                claims: claims,
                expires: DateTime.Now.AddMinutes(30),
                signingCredentials: credentials);

            return new JwtSecurityTokenHandler().WriteToken(token);
        }

        private static string GenerateSalt()
        {
            byte[] salt = new byte[128 / 8];
            using (var rng = new System.Security.Cryptography.RNGCryptoServiceProvider())
            {
                rng.GetBytes(salt);
            }
            return Convert.ToBase64String(salt);
        }

        private static string HashPassword(string password, string salt)
        {
            byte[] saltBytes = Convert.FromBase64String(salt);
            string hashed = Convert.ToBase64String(KeyDerivation.Pbkdf2(
                password: password,
                salt: saltBytes,
                prf: KeyDerivationPrf.HMACSHA256,
                iterationCount: 10000,
                numBytesRequested: 256 / 8));
            return hashed;
        }

        private static bool VerifyPassword(string password, string storedHash, string storedSalt)
        {
            string hash = HashPassword(password, storedSalt);
            return hash == storedHash;
        }

        public IActionResult Logout()
        {
            HttpContext.SignOutAsync();
            return RedirectToAction("Index", "Home");
        }

        [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
        public IActionResult Error()
        {
            return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
        }

        public IActionResult Team()
        {
            return View();
        }

        public IActionResult Portfolio()
        {
            return View();
        }
    }
}
