using Logicapps.Publish.App;
using Logicapps.Publish.App.Data;

var builder = WebApplication.CreateBuilder(args);

// Create an AppSettings class with the MyConnectionString property
// Add a user secret to this project with a MyConnectionString value
// This line will read from either local Secrets or from Azure App Config
var settings = new AppSettings(
    builder.Configuration["MySecret"].ToStringNullable(),
    builder.Configuration["ApplicationInsightsKey"].ToStringNullable(),
    builder.Configuration["PublishFunctionAppKey"].ToStringNullable()
);

// Add AppSettings to the application container for injection later
builder.Services.AddSingleton(settings);

builder.Services.AddSingleton(new TestRepository(settings));

// Add services to the container.
builder.Services.AddRazorPages();
builder.Services.AddServerSideBlazor();
builder.Services.AddSingleton<WeatherForecastService>();

var app = builder.Build();

// Configure the HTTP request pipeline.
if (!app.Environment.IsDevelopment())
{
    app.UseExceptionHandler("/Error");
    // The default HSTS value is 30 days. You may want to change this for production scenarios, see https://aka.ms/aspnetcore-hsts.
    app.UseHsts();
}

app.UseHttpsRedirection();

app.UseStaticFiles();

app.UseRouting();

app.MapBlazorHub();
app.MapFallbackToPage("/_Host");

app.Run();
