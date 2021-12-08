import './App.css';
import { СorrelationType } from './lab/CorrelationType';
import { HarmonicSignal } from './lab/HarmonicSignal';
import { Сorrelation } from './lab/Correlation';
import * as math from 'mathjs';
import { ResponsiveLine } from '@nivo/line';
import MenuItem from '@mui/material/MenuItem';
import Select from '@mui/material/Select';
import { useState } from 'react';

const N = 1024;

function Calculate(ct: СorrelationType) {
  const firstSignal: HarmonicSignal = new HarmonicSignal(100, 1, 0, N);
  const secondSignal: HarmonicSignal = new HarmonicSignal(80, 1.5, 30, N);
  let crossCorrelation: math.Complex[] = [];
  let fastCrossCorrelation: math.Complex[] = [];
  let time = 1;
  let fastTime = 1;
  switch (ct) {
    case СorrelationType.Cross: {
      const timeA = performance.now();
      crossCorrelation = Сorrelation.CrossCorrelation(
        firstSignal.signVal,
        secondSignal.signVal
      );
      time = performance.now() - timeA;
      const timeB = performance.now();
      fastCrossCorrelation = Сorrelation.FastCrossCorrelation(
        firstSignal.signVal,
        secondSignal.signVal
      );
      fastTime = performance.now() - timeB;

      break;
    }
    case СorrelationType.Auto: {
      const timeA = performance.now();
      crossCorrelation = Сorrelation.AutoCorrelation(firstSignal.signVal, 100);
      time = performance.now() - timeA;
      const timeB = performance.now();
      fastCrossCorrelation = Сorrelation.FastAutoCorrelation(
        firstSignal.signVal,
        100
      );
      fastTime = performance.now() - timeB;
      break;
    }
  }
  return {
    crossCorrelation,
    fastCrossCorrelation,
    firstSignal,
    secondSignal,
    time,
    fastTime,
  };
}

function App() {
  const [value, setValue] = useState<СorrelationType>(СorrelationType.Cross);

  const handleChange = (event: any) => {
    setValue(event.target.value);
  };
  const {
    crossCorrelation,
    fastCrossCorrelation,
    firstSignal,
    secondSignal,
    time,
    fastTime,
  } = Calculate(value);

  const signalsData = [
    {
      id: 'firstSignal',
      color: 'hsl(50, 70%, 50%)',
      data: firstSignal.signVal.map((x, i) => ({ x: i, y: x })),
    },
    {
      id: 'fastCrossCorrelation',
      color: 'hsl(150, 70%, 50%)',
      data:
        value === СorrelationType.Auto
          ? firstSignal.signVal.map((x, i) => ({ x: i, y: x }))
          : secondSignal.signVal.map((x, i) => ({
              x: i,
              y: x,
            })),
    },
  ];

  const data = [
    {
      id: 'crossCorrelation',
      color: 'hsl(346, 70%, 50%)',
      data: crossCorrelation.map((x, i) => ({ x: i, y: x.re })),
    },
    {
      id: 'fastCrossCorrelation',
      color: 'hsl(46, 70%, 50%)',
      data: fastCrossCorrelation.map((x, i) => ({
        x: i,
        y: x.re,
      })),
    },
  ];
  return (
    <div className="App">
      <div>
        Время обычной ${time}, время быстрой ${fastTime}
      </div>
      <Select
        labelId="demo-simple-select-label"
        id="demo-simple-select"
        value={value}
        label="Age"
        onChange={handleChange}
      >
        <MenuItem value={СorrelationType.Cross}>Взаимная корреляция</MenuItem>
        <MenuItem value={СorrelationType.Auto}>Авто корреляция</MenuItem>
      </Select>
      <div style={{width: '100vw', height: '80vh', display: 'flex', flexDirection: 'row'}}>
        <ResponsiveLine
          data={signalsData}
          margin={{ top: 50, right: 110, bottom: 50, left: 60 }}
          xScale={{ type: 'point' }}
          yScale={{
            type: 'linear',
            min: 'auto',
            max: 'auto',
            reverse: false,
          }}
          enablePoints={false}
          isInteractive={false}
          animate={false}
          axisTop={null}
          axisRight={null}
          axisBottom={null}
          axisLeft={{
            // orient: 'left',
            tickSize: 5,
            tickPadding: 5,
            tickRotation: 0,
            legend: 'count',
            legendOffset: -40,
            legendPosition: 'middle',
          }}
          pointSize={1}
          pointColor={{ theme: 'background' }}
          useMesh={true}
        />
        <ResponsiveLine
          data={data}
          margin={{ top: 50, right: 110, bottom: 50, left: 60 }}
          xScale={{ type: 'point' }}
          yScale={{
            type: 'linear',
            min: 'auto',
            max: 'auto',
            reverse: false,
          }}
          enablePoints={false}
          isInteractive={false}
          animate={false}
          axisTop={null}
          axisRight={null}
          axisBottom={null}
          axisLeft={{
            // orient: 'left',
            tickSize: 5,
            tickPadding: 5,
            tickRotation: 0,
            legend: 'count',
            legendOffset: -40,
            legendPosition: 'middle',
          }}
          pointSize={1}
          pointColor={{ theme: 'background' }}
          useMesh={true}
        />
      </div>
    </div>
  );
}

export default App;
