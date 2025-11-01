using EEWA.DAL.Context;
using EEWA.DAL.Model;

namespace EEWA.WEB.Components.Pages.Home;

public class HomeViewModel
{
    private readonly SandBoxContext _sandBoxContext;
    public List<Project> projects = new List<Project>();
    public List<ProjectSection> projectSections = new List<ProjectSection>();
    public List<Component> components = new List<Component>();

    public HomeViewModel(SandBoxContext sandBoxContext)
    {
        _sandBoxContext = sandBoxContext;
        SetCollection();
    }
    public IEnumerable<Project> GetProjects()
    {
        return projects;
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
        projects.AddRange(_sandBoxContext.Projects);
        var firstSection = projectSections.Where(s => s.SectionID == 1).FirstOrDefault();
    }
}
