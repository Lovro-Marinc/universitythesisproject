using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace EEWA.DAL.Migrations;

/// <inheritdoc />
public partial class Initial : Migration
{
    /// <inheritdoc />
    protected override void Up(MigrationBuilder migrationBuilder)
    {
        migrationBuilder.EnsureSchema(
            name: "dbo");

        migrationBuilder.CreateTable(
            name: "Component",
            schema: "dbo",
            columns: table => new
            {
                ComponentID = table.Column<int>(type: "int", nullable: false)
                    .Annotation("SqlServer:Identity", "1, 1"),
                SectionID = table.Column<int>(type: "int", nullable: true),
                Position = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: true),
                Description = table.Column<string>(type: "nvarchar(max)", nullable: true),
                Quantity = table.Column<decimal>(type: "decimal(10,2)", nullable: true),
                Unit = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: true),
                SupplyPerUnit = table.Column<decimal>(type: "decimal(10,2)", nullable: true),
                InstallationPerUnit = table.Column<decimal>(type: "decimal(10,2)", nullable: true),
                TotalPerUnit = table.Column<decimal>(type: "decimal(10,2)", nullable: true),
                Total = table.Column<decimal>(type: "decimal(10,2)", nullable: true),
                SortOrder = table.Column<int>(type: "int", nullable: true)
            },
            constraints: table =>
            {
                table.PrimaryKey("PK_Component", x => x.ComponentID);
            });

        migrationBuilder.CreateTable(
            name: "ProjectSection",
            schema: "dbo",
            columns: table => new
            {
                SectionID = table.Column<int>(type: "int", nullable: false)
                    .Annotation("SqlServer:Identity", "1, 1"),
                SectionName = table.Column<string>(type: "nvarchar(255)", maxLength: 255, nullable: true),
                SheetName = table.Column<string>(type: "nvarchar(255)", maxLength: 255, nullable: true),
                SortOrder = table.Column<int>(type: "int", nullable: true)
            },
            constraints: table =>
            {
                table.PrimaryKey("PK_ProjectSection", x => x.SectionID);
            });
    }

    /// <inheritdoc />
    protected override void Down(MigrationBuilder migrationBuilder)
    {
        migrationBuilder.DropTable(
            name: "Component",
            schema: "dbo");

        migrationBuilder.DropTable(
            name: "ProjectSection",
            schema: "dbo");
    }
}
