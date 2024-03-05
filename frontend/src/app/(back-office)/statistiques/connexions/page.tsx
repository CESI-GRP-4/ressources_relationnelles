"use client"
import React, { useState, useEffect } from 'react';
import TestChart from "@/components/back-office/statistics/connectionChart"; // Assuming TestChart is your ConnectionsChart
import DateRangePicker from '@/components/dateRangePicker';
import dayjs from 'dayjs';

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
                     <DateRangePicker
                            onChange={handleDateChange}
                            disableAfterToday
                            defaultValue={defaultDateRange}
                     />
                     <TestChart dateRange={dateRange}></TestChart>
              </>
       );
}
