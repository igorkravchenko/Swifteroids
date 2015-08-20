
class StarField : NSObject
{
    var view : StarFieldView
    
    init( view: StarFieldView )
    {
        self.view = view
        super.init()
    }
}