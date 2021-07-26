using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.SecretTemplates
{
    public class Template
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public int PasswordTypeId { get; set; }
        public Field[] Fields { get; set; }

        public string GetSlugName(string FieldName)
        {
            string slugName = null;
            foreach (var f in this.Fields)
            {
                if (f.Name.Equals(FieldName))
                {
                    slugName = f.Name;
                }
            }
            return slugName;
        }

        public Field GetField(string SlugName)
        {
            Field currentField = new Field();
            foreach (var f in this.Fields)
            {
                if (f.FieldSlugName.Equals(SlugName))
                {
                    currentField = f;
                }
            }
            return currentField;
        }
    }
}