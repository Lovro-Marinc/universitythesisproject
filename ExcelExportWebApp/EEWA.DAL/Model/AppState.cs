using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace EEWA.DAL.Model;
public class AppState
{
    private int? _selectedProjectId;

    public int? SelectedProjectId
    {
        get => _selectedProjectId;
        set
        {
            _selectedProjectId = value;
            NotifyStateChanged();
        }
    }

    public event Action OnChange;

    private void NotifyStateChanged() => OnChange?.Invoke();
}
