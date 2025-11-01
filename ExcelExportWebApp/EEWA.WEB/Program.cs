using EEWA.DAL;
using EEWA.DAL.Context;
using EEWA.DAL.Model;
using EEWA.WEB.Components;
using EEWA.WEB.Components.Layout.NavDrawer;
using EEWA.WEB.Components.Pages.Home;
using EEWA.WEB.Components.Pages.Import;
using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
builder.Services.AddRazorComponents()
    .AddInteractiveServerComponents();

var connectionString = builder.Configuration.GetConnectionString("DefaultConnection") ?? throw new InvalidOperationException("Connection string 'DefaultConnection' not found.");
builder.Services.AddDbContext<SandBoxContext>(options =>
    options.UseSqlServer(connectionString));
try
{
    using var connection = new SqlConnection(connectionString);
    await connection.OpenAsync();
    Console.WriteLine(" Successfully connected to SQL Server");
}
catch (Exception ex)
{
    Console.WriteLine($" Connection failed: {ex.Message}");
}

builder.Services.AddSingleton<TelerikNavMenuModel>();
builder.Services.AddSingleton<AppState>();
builder.Services.AddScoped<ImportViewModel>();
builder.Services.AddScoped<HomeViewModel>();
var app = builder.Build();

// Configure the HTTP request pipeline.
if (!app.Environment.IsDevelopment())
{
    app.UseExceptionHandler("/Error", createScopeForErrors: true);
    // The default HSTS value is 30 days. You may want to change this for production scenarios, see https://aka.ms/aspnetcore-hsts.
    app.UseHsts();
}

app.UseHttpsRedirection();

app.UseStaticFiles();
app.UseAntiforgery();

app.MapRazorComponents<App>()
    .AddInteractiveServerRenderMode();

app.Run();
