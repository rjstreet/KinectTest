public class MainFrame extends Frame {
    public MainFrame(OtherView other_view) {
        setBounds(0,0,640,480);
        add(other_view);
        other_view.init();
        show();
    }
}
