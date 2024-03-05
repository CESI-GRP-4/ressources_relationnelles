"use client";
import { Bar } from 'react-chartjs-2';
import {
       Chart as ChartJS,
       CategoryScale,
       LinearScale,
       BarElement,
       Title,
       Tooltip,
       Legend,
} from 'chart.js';
import { useEffect, useState } from 'react';

// Register the chart.js components we will use for the Bar chart
ChartJS.register(
       CategoryScale,
       LinearScale,
       BarElement,
       Title,
       Tooltip,
       Legend
);

interface ChartData {
       labels: string[];
       datasets: {
              label: string;
              data: number[];
              backgroundColor: string;
              borderColor: string;
       }[];
}

export default function ConnectionsChart({ dateRange, isPreview = false }: { dateRange?: { startDate: string, endDate: string }, isPreview?: boolean }) {
       const [data, setData] = useState<ChartData>({
              labels: [],
              datasets: [{
                     label: 'Nombre de connexions',
                     data: [],
                     backgroundColor: 'rgb(75, 192, 192)',
                     borderColor: 'rgba(75, 192, 192, 0.2)',
              }],
       });

       useEffect(() => {
              const endDate = new Date();
              const startDate = new Date();
              if (isPreview) {
                     startDate.setDate(endDate.getDate() - 6);
              } else {
                     startDate.setDate(endDate.getDate() - 90);
              }

              const tempLabels: string[] = [];
              const tempData: number[] = [];

              for (let d = new Date(startDate); d <= endDate; d.setDate(d.getDate() + 1)) {
                     tempLabels.push(`${d.getDate()}/${d.getMonth() + 1}`);
                     tempData.push(Math.floor(Math.random() * 20));
              }

              setData({
                     labels: tempLabels,
                     datasets: [{
                            label: 'Nombre de connexions',
                            data: tempData,
                            backgroundColor: 'rgb(75, 192, 192)',
                            borderColor: 'rgba(75, 192, 192, 0.2)',
                     }],
              });
       }, []);

       const options = {
              responsive: true,
              maintainAspectRatio: true,
              aspectRatio: 2,
       };

       return <Bar className='w-full' data={data} options={options} />;
}
