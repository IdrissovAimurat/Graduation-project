using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace WebApp.Models
{
    public class User
    {
        public int phoneNumber { get; }
        public string email { get; set; }
        public string name { get; set; }
    }
}
