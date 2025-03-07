<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">

    <title> KOYOI </title>
</head>
<style>

.habitpage{
    display: flex;
    width: 1000px;
    margin-left: 300px;
}
.myhabit{
    display: flex;
    background-color: beige;
    width: 300px;
    height: 300px;
}
.recommend-habit{
    background-color: blue;
    width: 300px;
    height: 300px;
}
.habit-firstline{
    display: flex;
}
.habit-calendar{
    background-color: blueviolet;
    width: 300px;
    height: 300px;
}
table {
    border-collapse: collapse;
    width: 100%;
    max-width: 400px;
    text-align: center;
    margin-top: 50px;

    font-size: 15pt;

}


.weekly-habit-check{
    background-color: cadetblue;
    width: 300px;
    height: 300px
}
.habit-secondline{
    display: flex;
}
.week-rate{
    background-color: aquamarine;
    width: 300px;
    height: 300px;
}
.habit-memo{
    background-color: chartreuse;
    width: 300px;
    height: 300px;
}


</style>
<body>

<div class="habitpage" >
    <div>
        <div class="myhabit">내습관</div>
        <div class="recommend-habit">추천습관</div>
    </div>
    <div>
    <div class="habit-firstline">
        <div class="habit-calendar">달력</div>
        <div class="weekly-habit-check">
            <table border="1">
                <tr>
                    <th></th>
                    <th>월</th>
                    <th>화</th>
                    <th>수</th>
                    <th>목</th>
                    <th>금</th>
                    <th>토</th>
                    <th>일</th>
                </tr>
                <tr>
                    <td>물마시기 습관</td>
                    <td>●</td> <td>×</td> <td>×</td> <td>●</td> <td>●</td> <td>●</td> <td>×</td>
                </tr>
                <tr>
                    <td>산책가기 습관</td>
                    <td>×</td> <td>×</td> <td>●</td> <td>×</td> <td>●</td> <td>×</td> <td>●</td>
                </tr>
            </table>
        </div>
    </div>
    <div class="habit-secondline">
        <div class="week-rate">주간달성률</div>
        <div class="habit-memo" >유저총평</div>
    </div>
    </div>
</div>



</body>
</html>
