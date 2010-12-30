using System;
using System.Collections.Generic;

namespace CarCheck.Gestores
{
    public static class GestorContactos
    {
        public static IList<ContactoDto> FindByNameAndType(string type, string startsWith)
        {
            List<ContactoDto> contactos = new List<ContactoDto>();

            for (int i = 0; i < 10; i++)
            {
                ContactoDto contacto = new ContactoDto();
                contacto.Name = string.Format("{1} - Contacto {2} - {0}", type, startsWith, i);
                contacto.Id = i;
                contacto.Telefono1 = string.Format("001-{0}-012", i);
                contacto.Telefono2 = string.Format("001-{0}-0135", i);
                contacto.Email = string.Format("email@contact_{0}.com", i);

                contactos.Add(contacto);    
            }
            return contactos;
        }
    }

    public class ContactoDto
    {
        private int _id;
        public int Id
        {
            get { return _id; }
            set { _id = value; }
        }

        private string _name;
        public String Name
        {
            get { return _name; }
            set { _name = value; }
        }

        private string _telefono1;
        public String Telefono1
        {
            get { return _telefono1; }
            set { _telefono1 = value; }
        }

        private string _telefono2;
        public String Telefono2
        {
            get { return _telefono2; }
            set { _telefono2 = value; }
        }

        private string _email;
        public String Email
        {
            get { return _email; }
            set { _email = value; }
        }
    }
}

