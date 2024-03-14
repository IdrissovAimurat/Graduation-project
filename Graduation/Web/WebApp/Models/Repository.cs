
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace WebApp.Models
{

    public class Repository : IRepository
    {
        private Dictionary<string, Product> products;
        public Repository()
        {
            products = new Dictionary<string, Product>();

            products.Add("1", new Product { Name = "ЖК Бай-тал", Price = 99M });

            products.Add("2", new Product { Name = "ЖК Алмарасан", Price = 29.99M });

            products.Add("3", new Product { Name = "ЖК Польша", Price = 40.5M });
        }

        public List<Product> Products()
        {
            return products.Values.ToList();
        }
    }

    public class NewRepository : IRepository
    {
        private Dictionary<string, Product> products;
        public NewRepository()
        {
            products = new Dictionary<string, Product>();

            products.Add("", new Product { Name = "ЖК Бай-тал", Price = 99M });

            products.Add("", new Product { Name = "ЖК Алмарасан", Price = 29.99M });

            products.Add("", new Product { Name = "ЖК Польша", Price = 40.5M });
        }

        public List<Product> Products()
        {
            return products.Values.ToList();
        }
    }
}
