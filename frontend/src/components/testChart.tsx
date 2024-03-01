"use client"
import { Line } from '@ant-design/charts';

const data = [
       { year: '1991', value: 3 },
       { year: '1992', value: 4 },
       { year: '1993', value: 3.5 },
       { year: '1994', value: 5 },
       { year: '1995', value: 4.9 },
       { year: '1996', value: 6 },
       { year: '1997', value: 7 },
       { year: '1998', value: 9 },
       { year: '1999', value: 13 },
];

export default function TestChart() {
       const config = {
              data,
              height: 400,
              xField: 'year',
              yField: 'value',
              point: {
                     size: 5,
                     shape: 'diamond',
              },
              label: {
                     style: {
                            fill: '#aaa',

                     },
              },
              tooltip: {
                     domStyles: {
                            'g2-tooltip': {
                                   fontFamily: 'Arial, sans-serif' // Set the desired font family here
                            }
                     }
              }
       };
       return (
              <div className="ant-design-charts">

                     <Line {...config} ></Line> </div>
       );
};
