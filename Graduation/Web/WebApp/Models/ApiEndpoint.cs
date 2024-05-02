using Microsoft.AspNetCore.Mvc.Infrastructure;

namespace WebApp.Models
{
    public class ApiEndpoint
    {
        public string Name { get; set; }
        public string Url { get; set; }
        public bool IsSecured { get; set; }
    }
}
