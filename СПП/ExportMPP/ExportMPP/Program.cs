using System;
using System.IO;
using System.Linq;
using System.Reflection;

namespace ExportMPP
{
    class Program
    {
        static void Main(string[] args)
        {
            string pathToFile = "";

            if (args.Length == 0)
            {
                Console.Write("Enter path to dll or exe file: ");
                pathToFile = Console.ReadLine();
            }
            else
            {
                pathToFile = args[0];
            }

            if (File.Exists(pathToFile) && (Path.GetExtension(pathToFile) == ".dll" || Path.GetExtension(pathToFile) == ".exe"))
            {
                Assembly assembly = Assembly.LoadFrom(pathToFile);
                Console.WriteLine("\n" + assembly.FullName + "\n");
                Type[] types = assembly.GetExportedTypes();
                types.Where(e => e == typeof(ExportClass));

                foreach (Type type in types)
                {
                    if (type.IsPublic)
                    {
                        object[] attributes = type.GetCustomAttributes(true);
                        foreach (object attribute in attributes)
                        {
                            Console.WriteLine(type.FullName);
                        }
                    }
                }
            }
            else
            {
                Console.WriteLine("\nInvalid file path or file\n");
            }

            Console.ReadKey();
        }
    }
}
