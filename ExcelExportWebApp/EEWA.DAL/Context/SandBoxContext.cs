using EEWA.DAL.Model;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace EEWA.DAL.Context;

public class SandBoxContext : DbContext
{
    public DbSet<ProjectSection> Sections { get; set; }
    public DbSet<Component> Components { get; set; }
    public DbSet<Project> Projects { get; set; }
    public SandBoxContext(DbContextOptions<SandBoxContext> options) : base(options)
    {

    }
    public SandBoxContext() { }
}
