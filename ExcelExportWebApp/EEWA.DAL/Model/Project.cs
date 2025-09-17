using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace EEWA.DAL.Model;
[Table("Projects", Schema = "dbo")]
public class Project
{
    [Key]
    public int ID { get; set; }

    [StringLength(255)]
    public string? ProjectName { get; set; }


}
