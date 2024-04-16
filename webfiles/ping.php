<?php
if ($_SERVER["REQUEST_METHOD"] == "POST" && isset($_POST['ip'])) {
    $ip = escapeshellarg($_POST['ip']); // Escape to prevent command injection

    // Run the ping command
    $command = "ping -c 4 " . $ip;
    $output = shell_exec($command);

    echo nl2br(htmlspecialchars($output));
} else {
    echo "Invalid request";
}
?>
