$(document).ready(function (){
    let rows = $("#responses");
    for (let i = 0; i < rows.length; i++) {
        let row = rows.eq(i);
        let fields = row.children();
        let x = fields.eq(0).text();
        let y = fields.eq(1).text();
        let r = fields.eq(2).text();
        let result = fields.eq(5).text() === 'Да';
        x /= r;
        x = x.toFixed(2);
        y /= r;
        y = y.toFixed(2);
        markPoint(x, y, r, result);
    }
});

function markPoint(x, y, r, result) {
    const circle = document.createElementNS('http://www.w3.org/2000/svg', 'circle');
    circle.setAttribute('r', '3');
    circle.setAttribute('cx', 200+150 /r * x);
    circle.setAttribute('cy', 200-150 / r * y);
    if (result){
        circle.setAttribute('fill', 'green');
    } else circle.setAttribute('fill', 'red');
    document.getElementById('svg').appendChild(circle);
}