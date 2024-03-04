"use client";
// Import necessary components and hooks from react and react-chartjs-2
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

// Register the chart.js components we will use for the Bar chart
ChartJS.register(
       CategoryScale,
       LinearScale,
       BarElement, // Register BarElement instead of PointElement and LineElement
       Title,
       Tooltip,
       Legend
);

export default function ConnectionsChart() {
       const data = {
              labels: ['Lundi', 'Mardi', 'Mercredi', 'Jeudi', 'Vendredi', 'Samedi', 'Dimanche'],
              datasets: [
                     {
                            label: 'Nombre de connexions',
                            data: [12, 19, 3, 5, 2, 3, 9], // Données fictives représentant les utilisateurs connectés chaque jour
                            backgroundColor: 'rgb(75, 192, 192)', // Used for the bar fill
                            borderColor: 'rgba(75, 192, 192, 0.2)', // Used for the bar border
                     },
              ],
       };

       const options = {
              responsive: true,
              maintainAspectRatio: true, // This should be true to maintain aspect ratio
              aspectRatio: 2, // Adjust this value according to your needs
              // plugins: {
              //        legend: {
              //               position: 'top' as const, // Ensure type correctness
              //        },
              // },
       };

       return (
              <Bar data={data} options={options} />
       );
}
