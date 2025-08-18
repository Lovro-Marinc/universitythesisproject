using Microsoft.Data.SqlClient;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace EWWA.DAL.Tests.Fixture;

public class SandboxFixture : IDisposable
{
    public string ConnectionString { get; } =
        "Server=localhost;Database=Sandbox;User id=sa;Password=yourStrong(!)Password;TrustServerCertificate=True";

    public SqlConnection Connection { get; private set; }

    public SandboxFixture()
    {
        Connection = new SqlConnection(ConnectionString);
        Connection.Open();  // open once for all tests
    }

    public void Dispose()
    {
        Connection.Dispose(); // cleanup after all tests in collection
    }
}