using EEWA.DAL.Context;
using EEWA.DAL.Model;
namespace EEWA.WEB.Components.Pages.Import;

public class ImportViewModel
{
    private readonly SandBoxContext _sandBoxContext;

    public List<ProjectSection> projectSections = new List<ProjectSection>();
    public List<Component> components = new List<Component>();

    public ImportViewModel(SandBoxContext sandBoxContext)
    {
        _sandBoxContext = sandBoxContext;
        SetCollection();
    }
    public IEnumerable<ProjectSection> GetProjectSection()
    {
        return projectSections;
    }
    public IEnumerable<Component> GetComponents()
    {
        return components;
    }
    public void SetCollection()
    {
        components.AddRange(_sandBoxContext.Components);
        projectSections.AddRange(_sandBoxContext.Sections);
        var firstSection = projectSections.Where(s => s.SectionID == 1).FirstOrDefault();
    }
}
