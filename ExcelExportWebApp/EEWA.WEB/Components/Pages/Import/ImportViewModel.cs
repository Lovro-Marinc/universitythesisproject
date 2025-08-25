using EEWA.DAL.Context;
using EEWA.DAL.Model;
using Telerik.Blazor.Components;
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

    public async Task OnGridCreate(GridCommandEventArgs args)
    {

        //var transObject = args.Item as ModelBase;
        //try
        //{
        //    await AddItemAsync(transObject);
        //}
        //catch (Exception e) { }


        //ClearAndAddToCollections(transObject);
    }
    public async Task DeleteComponentAsync(Component component, string? secitonID)
    {

    }
    public async Task OnGridUpdate(GridCommandEventArgs args)
    {
        try
        {
            //var transObject = args.Item as ModelBase;
            //var ctxItem = IndigomatContext.Find(transObject.GetType(), transObject.Id);
            //IndigomatContext.Entry(ctxItem).CurrentValues.SetValues(transObject);
            //var res = IndigomatContext.SaveChanges();
        }
        catch (Exception ex)
        {
            throw;
        }
    }
    public async Task OnGridDelete(GridCommandEventArgs args)
    {

        //var item = args.Item as ModelBase;
        //await DeleteItemAsync(item.Id, item);
    }
    public async Task AddItemAsync(ProjectSection section)
    {
        //IndigomatContext.Add(section);
        //await IndigomatContext.SaveChangesAsync();
        //ClearAndAddToCollections(section);
    }
    public async Task DeleteItemAsync(int id, Component item)
    {
        //var ctxItem = IndigomatContext.Find(item.GetType(), item.Id);
        //if (ctxItem != null)
        //{
        //    IndigomatContext.Remove(ctxItem);
        //    await IndigomatContext.SaveChangesAsync();
        //    ClearAndAddToCollections(item);
        //}
    }
}
