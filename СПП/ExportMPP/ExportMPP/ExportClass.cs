using System;

namespace ExportMPP
{
    [AttributeUsage(
        AttributeTargets.Class |
        AttributeTargets.Delegate |
        AttributeTargets.Enum |
        AttributeTargets.Struct |
        AttributeTargets.Interface
    )]

    internal class ExportClass : Attribute { }
}
