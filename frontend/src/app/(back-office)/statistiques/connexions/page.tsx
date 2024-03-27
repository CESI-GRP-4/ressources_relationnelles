"use client"
import React, { useState, useEffect } from 'react';
import ConnectionsChart from "@/components/back-office/statistics/connections/connectionChart";
import DateRangePicker from '@/components/dateRangePicker';
import dayjs from 'dayjs';
import { Typography } from 'antd';
import PageSummary from '@/components/back-office/pageSummary';

export default function ConnectionStats() {
       const defaultStartDate = dayjs().subtract(30, 'days').format('DD/MM/YYYY');
       const defaultEndDate = dayjs().format('DD/MM/YYYY');

       const [dateRange, setDateRange] = useState<{ startDate: string, endDate: string }>({
              startDate: defaultStartDate,
              endDate: defaultEndDate,
       });

       const handleDateChange = (dates: [string, string]) => {
              if (dates) {
                     setDateRange({ startDate: dates[0], endDate: dates[1] });
              }
       };

       const defaultDateRange = [dayjs(defaultStartDate, 'DD/MM/YYYY'), dayjs(defaultEndDate, 'DD/MM/YYYY')] as [dayjs.Dayjs, dayjs.Dayjs];

       return (
              <>
                     <div className="flex flex-col gap-5">
                            <PageSummary
                                   title="Statistiques de connexion"
                                   description="Visualiser le nombre de connexions par jour sur un lapse de temps souhaité." />
                                   
                            <div className="w-full flex flex-row justify-center">
                                   <div className='xl:w-4/5 w-full space-y-5'>
                                          <DateRangePicker
                                                 onChange={handleDateChange}
                                                 disableAfterToday
                                                 defaultValue={defaultDateRange}
                                          />
                                          <ConnectionsChart dateRange={dateRange}></ConnectionsChart>
                                   </div>
                            </div>
                     </div>
              </>
       );
}
