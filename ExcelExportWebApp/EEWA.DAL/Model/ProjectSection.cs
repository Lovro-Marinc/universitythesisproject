using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace EEWA.DAL.Model;
[Table("ProjectSection", Schema = "dbo")]
public class ProjectSection
{
    [Key]
    public int SectionID { get; set; }

    [StringLength(255)]
    public string? SectionName { get; set; }

    [StringLength(255)]
    public string? SheetName { get; set; }

    public int? SortOrder { get; set; }



    [ForeignKey("ProjectID")]
    public int ProjectID { get; set; }

}
