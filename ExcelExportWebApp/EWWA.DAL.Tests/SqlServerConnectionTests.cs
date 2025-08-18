using Microsoft.Data.SqlClient;
using Moq;
using System.Data;
using EWWA.DAL.Tests.Fixture;
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
    [Fact]
    public void TestConnectionIsOpen()
    {
        Assert.Equal(ConnectionState.Open, _fixture.Connection.State);
    }
    [Fact]
    public void TestCanQuery()
    {
        using var cmd = new SqlCommand("SELECT 1", _fixture.Connection);
        var result = cmd.ExecuteScalar();
        Assert.Equal(1, (int)result);
    }
}