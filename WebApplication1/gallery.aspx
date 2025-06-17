<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gallery - Online Salon and Spa Booking</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f9;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }

        header {
            background-color: #333;
            color: #fff;
            padding: 10px 0;
            text-align: center;
        }

            header h1 {
                margin: 0;
                font-size: 2em;
            }

        .gallery {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 20px;
            margin-top: 20px;
        }

        .gallery-item {
            background-color: #fff;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

            .gallery-item img {
                width: 100%;
                height: auto;
                display: block;
            }

            .gallery-item .description {
                padding: 15px;
                text-align: center;
                color: #555;
            }

                .gallery-item .description h3 {
                    margin: 0;
                    font-size: 1.2em;
                    color: #333;
                }

                .gallery-item .description p {
                    margin: 5px 0 0;
                    font-size: 0.9em;
                }

        footer {
            text-align: center;
            padding: 10px 0;
            margin-top: 20px;
            background-color: #333;
            color: #fff;
        }
    </style>
</head>
<body>
    <header>
        <h1>Gallery</h1>
    </header>

    <div class="container">
        <div class="gallery">
            <div class="gallery-item">
                <img src="https://via.placeholder.com/300x200" alt="Service 1">
                <div class="description">
                    <h3>Luxurious Spa Treatments</h3>
                    <p>Relax and rejuvenate with our premium spa services.</p>
                </div>
            </div>
            <div class="gallery-item">
                <img src="https://via.placeholder.com/300x200" alt="Service 2">
                <div class="description">
                    <h3>Professional Hair Styling</h3>
                    <p>Discover trendy and stylish haircuts tailored for you.</p>
                </div>
            </div>
            <div class="gallery-item">
                <img src="https://via.placeholder.com/300x200" alt="Service 3">
                <div class="description">
                    <h3>Manicure & Pedicure</h3>
                    <p>Keep your hands and feet looking their best.</p>
                </div>
            </div>
            <div class="gallery-item">
                <img src="https://via.placeholder.com/300x200" alt="Service 4">
                <div class="description">
                    <h3>Makeup Services</h3>
                    <p>Perfect looks for every occasion with professional makeup.</p>
                </div>
            </div>
            <div class="gallery-item">
                <img src="https://via.placeholder.com/300x200" alt="Service 5">
                <div class="description">
                    <h3>Relaxing Massages</h3>
                    <p>Relieve stress and tension with our expert masseurs.</p>
                </div>
            </div>
            <div class="gallery-item">
                <img src="https://via.placeholder.com/300x200" alt="Service 6">
                <div class="description">
                    <h3>Facial Treatments</h3>
                    <p>Experience glowing skin with our specialized facials.</p>
                </div>
            </div>
        </div>
    </div>

    <footer>
        <p>&copy; 2025 Online Salon and Spa Booking System. All rights reserved.</p>
    </footer>
</body>
</html>
