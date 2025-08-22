using Telerik.SvgIcons;

namespace EEWA.WEB.Components.Layout.NavDrawer;

public class TelerikNavMenuModel
{
    public class DrawerItem
    {
        public string Text { get; set; }
        public string Url { get; set; }
        public ISvgIcon Icon { get; set; }
        public bool Separator { get; set; }
    }
    public List<DrawerItem> NavigablePages { get; set; } = new List<DrawerItem>
    {
        new DrawerItem { Text = "Menu",  Icon = SvgIcon.Menu },
        new DrawerItem { Separator = true },
        new DrawerItem { Text = "Home", Url = "/", Icon = SvgIcon.Home },
        new DrawerItem { Text = "Import", Url = "import", Icon = SvgIcon.Import },
        new DrawerItem { Text = "Export", Url = "export", Icon = SvgIcon.Save }
    };
}
