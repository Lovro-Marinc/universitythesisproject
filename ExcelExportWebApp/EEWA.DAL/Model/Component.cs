using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using static System.Collections.Specialized.BitVector32;

namespace EEWA.DAL.Model;

public class Component
{
    [Key]
    public int ComponentID { get; set; }

    [ForeignKey("Section")]
    public int? SectionID { get; set; }

    [StringLength(50)]
    public string? Position { get; set; }

    public string? Description { get; set; }

    [Column(TypeName = "decimal(10,2)")]
    public decimal? Quantity { get; set; }

    [StringLength(50)]
    public string? Unit { get; set; }

    [Column(TypeName = "decimal(10,2)")]
    public decimal? SupplyPerUnit { get; set; }

    [Column(TypeName = "decimal(10,2)")]
    public decimal? InstallationPerUnit { get; set; }

    [Column(TypeName = "decimal(10,2)")]
    public decimal? TotalPerUnit { get; set; }

    [Column(TypeName = "decimal(10,2)")]
    public decimal? Total { get; set; }

    public int? SortOrder { get; set; }


    public virtual Section? Section { get; set; }
}