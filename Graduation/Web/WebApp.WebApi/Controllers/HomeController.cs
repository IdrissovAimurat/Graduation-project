using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using WebApp.WebApi.Data;
using WebApp.WebApi.Models;

namespace WebApp.WebApi.Controllers
{
    public class HomeController : ControllerBase
    {
        private WebAppContext _db;

        public HomeController(WebAppContext db)
        {
            _db = db;
        }

        [HttpGet("GetAllUsers")]
        public IEnumerable<User> GetAllUsers()
        {
            var users = _db.Users;
            return users;
        }
    }
}
