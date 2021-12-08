import './App.css';
import { ResponsiveLine } from '@nivo/line';
import { ResponsiveBar } from '@nivo/bar';
import { Butterfly, HarmonicSignal, PolyharmonicSignal } from './lab2';
import MenuItem from '@mui/material/MenuItem';
import Select from '@mui/material/Select';
import { useEffect, useMemo, useState } from 'react';
import Slider from '@mui/material/Slider';

const N = 1024;
const номерГармоники = 1;

const da = new HarmonicSignal();
const da1 = new PolyharmonicSignal();

function App() {
  const [chart, setChart] = useState('график_сигналов');
  const handleChangeCharts = event => {
    setChart(event.target.value);
  };

  const [типСигнала, установитьТипСигнала] = useState('Гармонический');
  const обработатьТипСигнала = event => {
    установитьТипСигнала(event.target.value);
  };

  const [тип_фильтрации, установить_тип_фильтрации] = useState('Нет');
  const обработатьТипФильтрации = event => {
    установить_тип_фильтрации(event.target.value);
  };

  const [частота, установитьЧастоту] = useState(20);
  const [нч, установитьНЧ] = useState(20);
  const [вч, установитьВЧ] = useState(20);

  const dataGarmoni = useMemo(() => da.GenerateTask2_1(частота), [частота]);

  let test;
  switch (тип_фильтрации) {
    case 'Нет':
      test = 4;
      break;
    case 'НЧ фильтр':
      test = 3;
      break;
    case 'ВЧ фильтр':
      test = 2;
      break;
    case 'Полосовый фильтр':
      test = 1;
      break;
    default:
      break;
  }
  const [dataPolygarmonic, setDataPolygarmonic] = useState({});

  useEffect(() => {
    const result = da1.GenerateTask3_1(частота, test, вч, нч);
    setDataPolygarmonic(result);
  }, [частота]);

  useEffect(() => {
    if (dataPolygarmonic.signal?.length) {
      const result = da1.RedreawTask3_1(test, вч, нч);
      setDataPolygarmonic(result);
    }
  }, [test, нч, вч]);
  let data1 = undefined;
  if (типСигнала === 'Гармонический') {
    data1 = dataGarmoni;
  } else {
    data1 = dataPolygarmonic;
  }

  const data = [
    {
      id: 'japan',
      data: (data1.signal || [])

        .filter((e, i) => i % 2 === 0)
        .map((x, i) => ({ x: i, y: x.toFixed(4) })),
    },
    {
      id: 'japan2',
      data: (data1.restoredSignal || []).map((x, i) => ({
        x: i,
        y: x.toFixed(4),
      })),
    },
    {
      id: 'japan3',
      data: (data1.restoredPhasedSignal || []).map((x, i) => ({
        x: i,
        y: x.toFixed(4),
      })),
    },
  ];

  const data2 = [
    {
      id: 'japan',
      color: 'hsl(346, 70%, 50%)',
      data: (data1.amplSpectrum || []).map((y, i) => ({ x: i, y })),
    },
  ];
  const data3 = [
    {
      id: 'japan',
      color: 'hsl(346, 70%, 50%)',
      data: (data1.phaseSpectrum || []).map((y, i) => ({ x: i, y })),
    },
  ];
  let data4 = [];
  if (типСигнала !== 'Гармонический') {
    if (data1.signal) {
      const dataFromBack = Butterfly.DecimationInTime(data1.signal, true);
      const temp = [];
      for (let i = 0; i < dataFromBack.length; i++) {
        let amplitude =
          ((dataFromBack[i].re ** 2 + dataFromBack[i].im ** 2) ** 0.5 * 2) / N;
        if (amplitude > 0.00001) {
          temp.push(amplitude); // targetCharts[3].Series[0].Points.AddXY(j++, amplitude);
        }
      }

      data4 = [
        {
          id: 'japan',
          color: 'hsl(346, 70%, 50%)',
          data: (temp || []).map((y, i) => ({ x: i, y })),
        },
      ];
    }
  }

  const barData2 = data2[0].data?.map(e => {
    return ({
      country: e.x,
      "value": e.y,
      "value valueColor": "hsl(0%, 100%, 20%)",
    })
  }) || []; 

  console.log(data3, data4);

  const barData3 = data3[0].data?.map(e => {
    return ({
      country: e.x,
      "value": e.y,
      "value valueColor": "hsl(0%, 100%, 20%)",
    })
  }) || []; 

  const barData4 = data4.length && data4[0].data?.map(e => {
    return ({
      country: e.x,
      "value": e.y,
      "value valueColor": "hsl(0%, 100%, 20%)",
    })
  }) || []; 

  return (
    <div className="App">
      <div style={{display: 'flex', flexWrap: 'wrap'}}>
        <div style={{width: '950px', height: '500px'}}>
          <div>График</div>
          <ResponsiveLine
            enableGridX={false}
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
              orient: 'left',
              tickSize: 5,
              tickPadding: 5,
              tickRotation: 0,
              legend: '',
              legendOffset: -40,
              legendPosition: 'middle',
            }}
            pointSize={1}
            pointColor={{ theme: 'background' }}
            useMesh={true}
            colors={{ scheme: 'paired' }}
          />
        </div>
        <div style={{width: '950px', height: '500px'}}>
          <div>Амплитудный спектр</div>
          <ResponsiveBar
            colors={{ scheme: 'paired' }}
            data={barData2}
            keys={[ 'value' ]}
            indexBy="country"
            margin={{ top: 50, right: 130, bottom: 50, left: 60 }}
            padding={0.3}
            valueScale={{ type: 'linear' }}
            indexScale={{ type: 'band', round: true }}
            axisTop={null}
            axisRight={null}
            axisBottom={null}
            axisLeft={{
                tickSize: 5,
                tickPadding: 5,
                tickRotation: 0,
                legend: '',
                legendPosition: 'middle',
                legendOffset: -40
            }}
            role="application"
            ariaLabel=""
            label={() => ''}
          />
        </div>
        <div style={{width: '950px', height: '500px'}}>
          <div>Фазовый спектр</div>
          <ResponsiveBar
            colors={{ scheme: 'paired' }}
            data={barData3}
            keys={[ 'value' ]}
            indexBy="country"
            margin={{ top: 50, right: 130, bottom: 50, left: 60 }}
            padding={0.3}
            valueScale={{ type: 'linear' }}
            indexScale={{ type: 'band', round: true }}
            axisTop={null}
            axisRight={null}
            axisBottom={null}
            axisLeft={{
                tickSize: 5,
                tickPadding: 5,
                tickRotation: 0,
                legend: '',
                legendPosition: 'middle',
                legendOffset: -40
            }}
            role="application"
            ariaLabel=""
            label={() => ''}
          />
        </div>
        {barData4.length &&
          <div style={{width: '950px', height: '500px'}}>
            <div>График быстрого преобразования фурье</div>
            <ResponsiveBar
              colors={{ scheme: 'paired' }}
              data={barData4}
              keys={[ 'value' ]}
              indexBy="country"
              margin={{ top: 50, right: 130, bottom: 50, left: 60 }}
              padding={0.3}
              valueScale={{ type: 'linear' }}
              indexScale={{ type: 'band', round: true }}
              axisTop={null}
              axisRight={null}
              axisBottom={null}
              axisLeft={{
                  tickSize: 5,
                  tickPadding: 5,
                  tickRotation: 0,
                  legend: '',
                  legendPosition: 'middle',
                  legendOffset: -40
              }}
              role="application"
              ariaLabel=""
              label={() => ''}
            />
          </div>
        }
      </div>
      <div style={{display: 'flex', flexDirection: 'row', marginTop: '1%'}}>
        <div style={{display: 'flex', flexDirection: 'column', margin: '2%'}}>
          <Select
            labelId="demo-simple-select-label"
            id="demo-simple-select"
            value={типСигнала}
            label="типСигнала"
            onChange={обработатьТипСигнала}
          >
            <MenuItem value={'Гармонический'}>Гармонический</MenuItem>
            <MenuItem value={'Полигармонический'}>Полигармонический</MenuItem>
          </Select>
          <Select
            labelId="demo-simple-select-label"
            id="demo-simple-select"
            value={тип_фильтрации}
            label="тип_фильтрации"
            onChange={обработатьТипФильтрации}
          >
            <MenuItem value={'Нет'}>Нет</MenuItem>
            <MenuItem value={'НЧ фильтр'}>НЧ фильтр</MenuItem>
            <MenuItem value={'ВЧ фильтр'}>ВЧ фильтр</MenuItem>
            <MenuItem value={'Полосовый фильтр'}>Полосовый фильтр</MenuItem>
          </Select>
        </div>
        <div style={{display: 'flex', flexDirection: 'column', width: '60%', marginLeft: '5%'}}>
          <label>
            Частота
            <Slider
              size="small"
              min={1}
              max={30}
              // defaultValue={20}
              value={частота}
              onChange={value => {
                установитьЧастоту(value.target.value);
              }}
              aria-label="Small"
              valueLabelDisplay="auto"
            />
          </label>
          <label>
            ВЧ
            <Slider
              size="small"
              min={1}
              max={30}
              value={вч}
              onChange={value => {
                установитьВЧ(value.target.value);
              }}
              aria-label="Small"
              valueLabelDisplay="auto"
            />
          </label>
          <label>
            НЧ
            <Slider
              size="small"
              min={0}
              max={30}
              value={нч}
              onChange={value => {
                установитьНЧ(value.target.value);
              }}
              aria-label="Small"
              valueLabelDisplay="auto"
            />
          </label>
        </div>
      </div>
    </div>
  );
}

export default App;
