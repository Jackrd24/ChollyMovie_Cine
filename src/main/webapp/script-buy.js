const container = document.querySelector(".container");
const seats = document.querySelectorAll(".row .seat:not(.sold)");
const count = document.getElementById("count");
const total = document.getElementById("total");

const selectedSeats = [];

function toggleSeat(seat) {
    seat.classList.toggle("selected");

    const seatName = seat.innerText;
    const seatIndex = selectedSeats.indexOf(seatName);

    if (seatIndex === -1) {
        selectedSeats.push(seatName);
    } else {
        selectedSeats.splice(seatIndex, 1);
    }

    updateSelectedCount();
}

function updateSelectedCount() {
    count.innerText = selectedSeats.length;
    total.innerText = selectedSeats.length * ticketPrice;
}

document.getElementById("continueButton").addEventListener("click", function () {
    const selectedSeatsParam = encodeURIComponent(selectedSeats.join(","));
    const finalPrice = selectedSeats.length * ticketPrice;
    console.log(finalPrice);
    window.location.href = `confirm_purchase.jsp?id=${movieId}&asientos=${selectedSeatsParam}&precio=${finalPrice}`;
});

updateSelectedCount();

