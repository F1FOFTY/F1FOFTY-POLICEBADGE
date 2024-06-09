window.addEventListener('message', function(event) {
    let data = event.data;

    if (data.action === "open") {
        document.getElementById('name').value = data.name;
        document.getElementById('badgeNumber').value = data.badgeNumber;
        document.getElementById('picture').value = data.picture;
        document.getElementById('department').value = data.department;
        document.getElementById('rank').value = data.rank;
        document.getElementById('app').style.display = "block";
    } else if (data.action === "showStolenBadge") {
        document.getElementById('app').style.display = "none";
        alert('This badge is stolen!');
    } else if (data.action === "close") {
        document.getElementById('app').style.display = "none";
    }
});

function closeUI() {
    fetch('https://qb-flashbadge/close', {
        method: 'POST'
    });
}

function changeRank() {
    let rank = document.getElementById('rank').value;
    fetch('https://qb-flashbadge/changeRank', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({ rank: rank })
    });
}

function updateInfo() {
    let name = document.getElementById('name').value;
    let badgeNumber = document.getElementById('badgeNumber').value;
    let picture = document.getElementById('picture').value;
    let department = document.getElementById('department').value;

    fetch('https://qb-flashbadge/updateInfo', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({ name: name, badgeNumber: badgeNumber, picture: picture, department: department })
    });
}

