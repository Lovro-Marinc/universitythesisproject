using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace EEWA.DAL.Model;

public class ProjectSection
{
    [Key]
    public int SectionID { get; set; }

    [StringLength(255)]
    public string? SectionName { get; set; }

    [StringLength(255)]
    public string? SheetName { get; set; }

    public int? SortOrder { get; set; }


    public virtual ICollection<Component> Components { get; set; } = new List<Component>();
}
