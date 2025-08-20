using EEWA.DAL.Context;
using EWWA.DAL.Tests.Fixture;
using Microsoft.Data.SqlClient;
using Moq;
using System.Collections.ObjectModel;
using System.ComponentModel;
using System.Data;
namespace EWWA.DAL.Tests;
[CollectionDefinition("Database collection")]
public class DatabaseCollection : ICollectionFixture<SandboxFixture> { }

[Collection("Database collection")]
public class SqlServerConnectionTests
{

    private readonly SandboxFixture _fixture;

    public SqlServerConnectionTests(SandboxFixture fixture)
    {
        _fixture = fixture;  // xUnit injects it
    }

    #region=========================================Database===================================
    [Fact]
    [Category("DB connection")]
    public void TestConnectionIsOpen()
    {
        Assert.Equal(ConnectionState.Open, _fixture.Connection.State);
    }
    [Fact]
    [Category("DB query")]
    public void TestCanQuery()
    {
        using var cmd = new SqlCommand("SELECT 1", _fixture.Connection);
        var result = cmd.ExecuteScalar();
        Assert.Equal(1, (int)result);
    }
    [Fact]
    [Category("DB query")]
    public async Task TestContextConnectionAsync()
    {
        SandBoxContext sandBox = _fixture.sandBoxContext;
        int sectionID = 2;
        var test = sandBox;
        var projectSections = sandBox.Sections
                                   .Where(s => s.SectionID == sectionID)
                                   .Select(s => s.SectionName)
                                   .FirstOrDefault();

        Assert.Equal("Priprava in razvod GM-25_-15", projectSections);
    }
    #endregion
}