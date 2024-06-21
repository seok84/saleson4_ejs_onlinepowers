/**
 * 자바스크립트 날짜 처리 클래스
 *
 * @Author skc@onlinepowers.com
 * @Date 2023-03-16
 *
 * - 날짜 계산 : 며칠, 몇달, 몇년 전후 날짜를 계산해 줌.
 *
 * # 사용방법
 *      LocalDate.of(new Date());
 *      LocalDate.of(2023,3, 16);
 *
 * # Methods
 *      minusDays, minusMonths, minusYears, plusDays, plusMonths, plusYears, toString
 *
 * # Date Format
 *  toString 메서드와 delimiter로 날짜 변환
 *      - toString() => '20230316'
 *      - toString('-') => '2023-03-16'
 *      - toString('.') => '2023.03.16'
 *
 */
export default class LocalDate {
    constructor(date) {
        if (date === undefined) {
            this.date = new Date();
        } else {
            this.date = date;
        }
    }
    static now() {
        return new LocalDate();
    }

    static of(dateOrYear, month, dayOfMonth) {
        if (typeof dateOrYear === "object") {
            return new LocalDate(dateOrYear);
        } else if (typeof dateOrYear === "number" && typeof month === "number"
            && typeof dayOfMonth === "number") {
            return new LocalDate(new Date(dateOrYear, month - 1, dayOfMonth));
        }

        throw "[LocalDate] Parameter Error. (Use LocalDate.of(Date) or LocalDate.of(int year, int month, int dayOfMonth))";
    }

    minusDays(days) {
        return LocalDate.of(new Date(this.date.setDate(this.date.getDate() - days)));
    }

    minusMonths(months) {
        return LocalDate.of(new Date(this.date.setMonth(this.date.getMonth() - months)));
    }

    minusYears(years) {
        return LocalDate.of(new Date(this.date.setFullYear(this.date.getFullYear() - years)));
    }

    plusDays(days) {
        return LocalDate.of(new Date(this.date.setDate(this.date.getDate() + days)));
    }

    plusMonths(months) {
        return LocalDate.of(new Date(this.date.setMonth(this.date.getMonth() + months)));
    }

    plusYears(years) {
        return LocalDate.of(new Date(this.date.setFullYear(this.date.getFullYear() + years)));
    }

    getDateArray() {
        const year = this.date.getFullYear();
        const month = this.addLeftPadding(this.date.getMonth() + 1);
        const day = this.addLeftPadding(this.date.getDate());

        return [year, month, day]
    }
    addLeftPadding(value) {
        if (value >= 10) {
            return value;
        }

        return `0${value}`;
    }

    /**
     * LocalDate 날짜를 문자열로 리턴함.
     * @param delimiter
     * @returns {string}
     */
    toString(delimiter) {
        if (delimiter === undefined) {
            delimiter = "";
        }

        return this.getDateArray().join(delimiter);
    }

    toLocalizedString() {
        const dateArray = this.getDateArray();
        return `${dateArray[0]}년 ${dateArray[1]}월 ${dateArray[2]}일`;
    }

}