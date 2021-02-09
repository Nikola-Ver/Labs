using System;
using System.Collections.Generic;
using System.Linq;
using System.Windows;

namespace Algorithms
{
    public class MaxMin : AlgorithmBase
    {
        private readonly Random random = new Random();

        public MaxMin(IEnumerable<Point> points)
        {
            Points = new List<Point>(points);
            Point firstCenter = Points[random.Next(Points.Count)];
            Classes = new List<PointsClass> { new PointsClass(firstCenter) };
        }

        public List<PointsClass> GetReadyClasses()
        {
            Point? newCenter;
            do
            {
                ClearClasses();
                AddPointsToClasses();
                newCenter = GetNewCenter();
                AddCenter(newCenter);
             } while (newCenter!= null);
            return Classes;
        }

        private void AddCenter(Point? newCenter)
        {
            if (newCenter != null)
            {
                Classes.Add(new PointsClass(newCenter.Value));
            }
        }


        private Point? GetNewCenter()
        {
            double averageCenterDistance = GetAverageCenterDistance();
            ClassMaxPoint newCenterCandidate = GetMaxPoint(GetClassesMaxPoints());
            if (newCenterCandidate.PointDistance > averageCenterDistance/2)
            {
                return newCenterCandidate.MaxPoint;
            }
            return null;
        }

        private double GetAverageCenterDistance()
        {
            double distanceSum = 0.0;
            for (int i = 0; i < Classes.Count; i++)
            {
                for (int j = i + 1; j < Classes.Count; j++)
                {
                    distanceSum += GetPointsInstance(Classes[i].Center, Classes[j].Center);
                }
            }
            int count = Enumerable.Range(1, Classes.Count - 1).Sum();
            return count == 0 ? 0 : distanceSum/count;
        }


        private ClassMaxPoint GetMaxPoint(IEnumerable<ClassMaxPoint> points)
        {
            var maxPoint = new ClassMaxPoint { PointDistance = 0 };
            foreach (var point in points)
            {
                if (point.PointDistance > maxPoint.PointDistance)
                {
                    maxPoint = point;
                }
            }
            return maxPoint;
        }

        private IEnumerable<ClassMaxPoint> GetClassesMaxPoints()
        {
            foreach (PointsClass pointsClass in Classes)
            {
                yield return GetClassMaxPoint(pointsClass);
            }
        }

        private ClassMaxPoint GetClassMaxPoint(PointsClass pointClass)
        {
            var maxPoint = new ClassMaxPoint {PointDistance = 0};
            foreach (var point in pointClass.Points)
            {
                double pointDistanse = GetPointsInstance(point, pointClass.Center);
                if (pointDistanse > maxPoint.PointDistance)
                {
                    maxPoint = new ClassMaxPoint {PointDistance = pointDistanse,
                        MaxPoint = point};
                }
            }
            return  maxPoint;
        }

        private class ClassMaxPoint
        {
            public double PointDistance { get; set; }

            public Point MaxPoint { get; set; }

        }
    }
}
