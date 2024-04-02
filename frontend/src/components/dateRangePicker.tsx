import { DatePicker } from 'antd';
import dayjs, { Dayjs } from 'dayjs';

const { RangePicker } = DatePicker;

/**
 * `DateRangePicker` is a component for selecting a range of dates.
 * It wraps Ant Design's `RangePicker` with additional functionality for disabling dates.
 *
 * Props:
 * - `onChange`: Callback function that is called when the range changes. It receives an array of two strings representing the start and end dates.
 * - `format`: (Optional) String format of the displayed dates. Defaults to 'DD/MM/YYYY'.
 * - `disabledDate`: (Optional) Function that determines whether a specific date should be disabled. Receives the current date as a `Dayjs` object and returns a boolean.
 * - `disableAfterToday`: (Optional) Boolean that, if true, disables all dates after today.
 * - `disableBeforeToday`: (Optional) Boolean that, if true, disables all dates before today.
 * - `defaultValue`: (Optional) Array of two `Dayjs` objects representing the default start and end dates.
 *
 * Example usage:
 * ```jsx
 * <DateRangePicker
 *   onChange={(dates) => console.log(dates)}
 *   disableBeforeToday
 *   defaultValue={[dayjs().subtract(7, 'days'), dayjs()]}
 *   disabledDate={(current: Dayjs | null) => {
 *     // Disable dates before today
 *     return current ? current.isBefore(dayjs().startOf('day')) : false;
 *   }}
 * />
 * ```
 *
 * Note: `disabledDate` is a flexible prop that allows for custom date disabling logic.
 * If both `disableAfterToday` and `disableBeforeToday` are provided, only the last one takes effect.
 */
export default function DateRangePicker({ onChange, format = 'DD/MM/YYYY', disabledDate, disableAfterToday, disableBeforeToday, defaultValue }: { onChange?: (dates: [string, string]) => void, format?: string, disabledDate?: (current: Dayjs | null) => boolean, disableAfterToday?: boolean, disableBeforeToday?: boolean, defaultValue?: [Dayjs, Dayjs] }) {
       if (disableAfterToday) {
              disabledDate = (current: Dayjs | null): boolean => {
                     return current ? current > dayjs().endOf('day') : false;
              }
       }
       if (disableBeforeToday) {
              disabledDate = (current: Dayjs | null): boolean => {
                     return current ? current < dayjs().startOf('day') : false;
              }
       }

       return (
              <RangePicker
                     defaultValue={defaultValue}
                     format={{
                            format: format,
                            type: 'mask',
                     }}
                     disabledDate={disabledDate}
                     onChange={(dates, dateStrings) => {
                            if (onChange) {
                                   onChange(dateStrings);
                            }
                     }}
              />
       );
}