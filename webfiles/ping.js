function ping() {
    var ip = document.getElementById("ipAddress").value;
    var xhr = new XMLHttpRequest();
    xhr.open("POST", "ping.php", true);
    xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    xhr.onreadystatechange = function () {
        if (this.readyState === 4 && this.status === 200) {
            document.getElementById("output").textContent += this.responseText + "\n";
        }
    };
    xhr.send("ip=" + encodeURIComponent(ip));
}
