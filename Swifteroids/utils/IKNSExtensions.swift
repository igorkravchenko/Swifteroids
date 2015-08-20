extension NSMapTable : SequenceType
{
    subscript ( key : AnyObject? ) -> AnyObject?
    {
        get
        {
            return objectForKey( key )
        }
        
        set ( newValue )
        {
            setObject( newValue, forKey : key)
        }
    }
    
    public func generate() -> NSFastGenerator
    {
        return NSFastGenerator( self )
    }
}