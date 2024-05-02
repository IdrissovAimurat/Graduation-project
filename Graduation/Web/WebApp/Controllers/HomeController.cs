using WebApp.Models;
using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Authentication.Cookies;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Localization;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using Serilog;
using System.Globalization;
using System.Linq;
using System.Security.Claims;
using System.Threading.Tasks;


namespace WebApp.Controllers
{
    public class HomeController : Controller
    {
        private readonly ILogger<HomeController> _logger;
        private IConfiguration _config;
        private IOptions<ApiEndpoint> _settings;
        //        private readonly IRepository _repo;
        //        private readonly IHttpContextAccessor _context;
        private readonly IStringLocalizer<HomeController> _local;


        public HomeController(ILogger<HomeController> logger,
                         //IRepository repo,
                         //IHttpContextAccessor context,
                         //IStringLocalizer<HomeController> local
                         IConfiguration config,
                         IOptions<ApiEndpoint> settings)
        {
            _logger = logger;
            _config = config;
            _settings = settings;
//            _repo = repo;
//            _context = context;
//            _local = local;
        }
        public IActionResult AboutUs()
        {

            string key = "IIN";
            string value = "880111300392";

            CookieOptions options = new CookieOptions();
            options.Expires = DateTime.Now.AddDays(1);

            Response.Cookies.Append(key, value);
            Response.Cookies.Append("key_2", value);
            Response.Cookies.Append("key_3", value);



            return View();
        }
        public IActionResult Index(string culture ="")
            //string cultureUI)
        {
            var data0 = _settings.Value.Url;
            var data =
                _config.GetSection("Middleware")
                .GetSection("EnableContentMiddleware")
                .Value;

            var data2 =
            _config.GetSection("Middleware")
            .GetValue<bool>("EnableContentMiddleware");


            var data3 = _config
                .GetSection("Middleware:EnableContentMiddleware")
                .Value;

            if (!string.IsNullOrEmpty(culture))
            {
                CultureInfo.CurrentCulture = new CultureInfo(culture);
                CultureInfo.CurrentUICulture = new CultureInfo(culture);
            }
            
            
            //ViewBag.About_us = _local["About_us"];
                
//            GetCulture(culture);


            HttpContext.Session.SetString("product", "Auto");

            string value = HttpContext.Session.GetString("product");


            _logger.LogInformation("testInfo");
            _logger.LogError("testInfo");

            string email = "ok@ok.kz";
            _logger.LogWarning("testInfo: {email} - {logTime}",
                email, DateTime.Now);

            return View();
        }
        public string GetCulture(string code)
        {
            if (string.IsNullOrWhiteSpace(code))
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

            CookieOptions options = new CookieOptions();
            options.Expires = DateTime.Now.AddDays(1);

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
        //ne ispolzuetsya
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

            if ((username == "admin") && (password == "admin"))
            {
                var number = phoneNumber;
                var claims = new List<Claim>
                {
                    new Claim(ClaimTypes.Name, username)
                };
                var claimsIdentity = new ClaimsIdentity(claims, "Login");

                HttpContext.SignInAsync(CookieAuthenticationDefaults.AuthenticationScheme, new ClaimsPrincipal(claimsIdentity));

                return Redirect(ReturnUrl);
            }


            return View();
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

        //public string GetCulture(string code = "")
        //{
        //    if (!string.IsNullOrWhiteSpace(code))
        //    {
        //        CultureInfo.CurrentCulture = new CultureInfo(code);
        //        CultureInfo.CurrentUICulture = new CultureInfo(code);

        //      //  ViewBag.Culture = string.Format("CurrentCulture: {0}, CurrentUICulture: {1}", CultureInfo.CurrentCulture,
        //      //      CultureInfo.CurrentUICulture);
        //    }
        //    return "";
        //}
        public IActionResult Team()
        {
            return View();
        }
    }
}
