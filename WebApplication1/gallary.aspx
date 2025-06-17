<%@ Page Title="Salon Gallery" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeFile="gallary.aspx.cs" Inherits="WebApplication1.gallary" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/Lightbox2/2.11.3/css/lightbox.min.css" rel="stylesheet" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet" />
    <style>
        /* Global Styles */
        body {
            font-family: 'Montserrat', sans-serif;
            background-color: #f8f9fa;
        }

        /* Gallery Header */
        .gallery-header {
            text-align: center;
            padding: 50px 0 30px;
            background: linear-gradient(to right, #f5f7fa, #e0e0e0);
            margin-bottom: 20px;
            box-shadow: 0 4px 10px rgba(0,0,0,0.05);
        }

        .gallery-title {
            font-size: 2.8rem;
            font-weight: 700;
            color: #333;
            margin-bottom: 15px;
            text-transform: uppercase;
            letter-spacing: 1px;
            text-shadow: 1px 1px 2px rgba(0,0,0,0.1);
        }

        .gallery-subtitle {
            color: #555;
            max-width: 800px;
            margin: 0 auto 20px;
            font-size: 1.1rem;
        }

        /* Gallery Container */
        .gallery-container {
            padding: 0 20px;
            max-width: 1400px;
            margin: 0 auto;
        }

        /* Gallery Row */
        .gallery-row {
            display: flex;
            flex-wrap: wrap;
            margin: -15px;
        }

        /* Gallery Card */
        .gallery-card {
            flex: 0 0 calc(33.333% - 30px);
            margin: 15px;
            border-radius: 10px;
            overflow: hidden;
            position: relative;
            box-shadow: 0 5px 15px rgba(0,0,0,0.08);
            transition: all 0.4s ease;
            background-color: white;
        }

        .gallery-card:hover {
            transform: translateY(-8px);
            box-shadow: 0 10px 25px rgba(0,0,0,0.15);
        }

        /* Image Container */
        .image-container {
            position: relative;
            overflow: hidden;
            width: 100%;
            height: 350px;
        }

        .gallery-img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 0.5s ease;
        }

        .gallery-card:hover .gallery-img {
            transform: scale(1.07);
        }

        /* Category Label */
        .category-label {
            position: absolute;
            top: 15px;
            right: 15px;
            background: rgba(0,0,0,0.6);
            color: white;
            padding: 5px 12px;
            border-radius: 20px;
            font-size: 0.8rem;
            font-weight: 500;
            z-index: 2;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        /* Card Content */
        .card-content {
            padding: 20px;
            position: relative;
        }

        .image-title {
            font-size: 1.2rem;
            font-weight: 600;
            margin-bottom: 5px;
            color: #333;
        }

        .image-description {
            color: #666;
            font-size: 0.95rem;
            margin-bottom: 15px;
        }

        /* View Button */
        .view-button {
            display: inline-block;
            background: linear-gradient(135deg, #333 0%, #111 100%);
            color: white;
            padding: 8px 20px;
            border-radius: 25px;
            text-decoration: none;
            font-weight: 500;
            font-size: 0.9rem;
            transition: all 0.3s ease;
            border: none;
            cursor: pointer;
        }

        .view-button:hover {
            background: linear-gradient(135deg, #444 0%, #222 100%);
            transform: translateY(-2px);
            box-shadow: 0 5px 10px rgba(0,0,0,0.1);
        }

        /* Featured Label */
        .featured-label {
            position: absolute;
            top: 15px;
            left: 15px;
            background: linear-gradient(135deg, #ff6b6b 0%, #ee5253 100%);
            color: white;
            padding: 5px 12px;
            border-radius: 20px;
            font-size: 0.8rem;
            font-weight: 500;
            z-index: 2;
        }

        /* Full-Width Feature */
        .full-width-feature {
            margin: 40px 0;
            padding: 40px;
            background: linear-gradient(to right, #333, #111);
            border-radius: 10px;
            color: white;
            text-align: center;
        }

        .feature-title {
            font-size: 2rem;
            margin-bottom: 20px;
            font-weight: 700;
        }

        .feature-subtitle {
            font-size: 1.1rem;
            margin-bottom: 30px;
            opacity: 0.9;
            max-width: 800px;
            margin-left: auto;
            margin-right: auto;
        }

        /* Filter Buttons */
        .filter-buttons {
            display: flex;
            justify-content: center;
            flex-wrap: wrap;
            gap: 10px;
            margin-bottom: 30px;
        }
        
        .filter-btn {
            background-color: white;
            border: 1px solid #ddd;
            color: #555;
            padding: 8px 20px;
            border-radius: 25px;
            cursor: pointer;
            transition: all 0.3s ease;
            font-weight: 500;
        }
        
        .filter-btn:hover, .filter-btn.active {
            background-color: #333;
            color: white;
            box-shadow: 0 5px 10px rgba(0,0,0,0.1);
        }

        /* Responsive Adjustments */
        @media (max-width: 1200px) {
            .gallery-card {
                flex: 0 0 calc(50% - 30px);
            }
        }

        @media (max-width: 768px) {
            .gallery-card {
                flex: 0 0 calc(100% - 30px);
            }
            
            .gallery-title {
                font-size: 2.2rem;
            }
            
            .full-width-feature {
                padding: 30px 20px;
            }
            
            .feature-title {
                font-size: 1.8rem;
            }
        }
        .filter-btn {
    background-color: white;
    border: 1px solid #ddd;
    color: #555;
    padding: 8px 20px;
    border-radius: 25px;
    cursor: pointer;
    transition: all 0.3s ease;
    font-weight: 500;
    text-decoration: none; /* Remove underline */
}

.filter-btn:hover, .filter-btn.active {
    background-color: #333;
    color: white;
    box-shadow: 0 5px 10px rgba(0,0,0,0.1);
    text-decoration: none; /* Ensure no underline on hover */
}

    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <!-- Gallery Header -->
    <div class="gallery-header">
        <div class="container">
            <h1 class="gallery-title">N S Salon Gallery</h1>
            <p class="gallery-subtitle">Explore our collection of haircuts, styling, and salon experiences that showcase our artistic vision and commitment to excellence.</p>
            
            <!-- Filter Buttons -->
  <div class="filter-buttons">
    <a href="SalonServices.aspx" class="filter-btn active">All Styles</a>
    <a href="haircut.aspx" class="filter-btn">Haircuts</a>
    <a href="touchups.aspx" class="filter-btn">Styling</a>
    <a href="haircolors.aspx" class="filter-btn">Color</a>
    <a href="spaservices.aspx" class="filter-btn">Salon</a>
</div>



        </div>
    </div>

    <!-- Gallery Container -->
    <div class="gallery-container">
        <div class="gallery-row">
            <% 
            string[] categories = { "haircuts", "styling", "color", "salon" };
            string[] titles = { 
                "Modern Fade Cut", "Elegant Styling", "Vibrant Color", 
                "Premium Workspace", "Classic Undercut", "Wavy Blowout",
                "Balayage Highlights", "VIP Experience", "Precision Cut",
                "Natural Waves", "Bold Color Transformation", "Relaxation Area"
            };
            
            string[] descriptions = {
                "Clean, contemporary style with perfect graduation.",
                "Sophisticated look that enhances natural features.",
                "Stunning hues that make a statement.",
                "Luxury environment for the ultimate experience.",
                "Timeless look with modern execution.",
                "Voluminous style with movement and shine.",
                "Subtle, sun-kissed highlights for dimension.",
                "First-class treatment in our exclusive area.",
                "Detailed craftsmanship for the perfect shape.",
                "Effortless texture that enhances natural beauty.",
                "Dramatic color change for a fresh look.",
                "Comfortable setting for your styling journey."
            };
            
            // Featured items - will mark every 5th item as featured
            bool[] featured = new bool[24];
            for (int f = 4; f < 24; f += 5) {
                featured[f] = true;
            }
            
            for (int i = 0; i < 24; i++) { 
                int imageIndex = (5656 + i + 1);
                string category = categories[i % categories.Length];
                string title = titles[i % titles.Length];
                string description = descriptions[i % descriptions.Length];
                
                // Every 7th item will be a full-width feature
                if (i > 0 && i % 7 == 0) {
            %>
                <!-- Full Width Feature -->
                <div class="full-width-feature">
                    <h2 class="feature-title">Experience Premium Hair Care</h2>
                    <p class="feature-subtitle">Our gallery showcases the artistic talents of our expert stylists. Each cut, color, and style represents our commitment to excellence and personalized beauty solutions.</p>
                    <a href="SalonServices.aspx" class="view-button">Book Your Session</a>
                </div>
            <% } %>
            
            <!-- Gallery Card -->
            <div class="gallery-card" data-category="<%= category %>">
                <div class="image-container">
                    <% if (featured[i]) { %>
                    <div class="featured-label"><i class="fas fa-star"></i> Featured</div>
                    <% } %>
                    <div class="category-label"><i class="fas fa-tag"></i> <%= char.ToUpper(category[0]) + category.Substring(1) %></div>
                    <a href='<%= "Images/IMG_" + imageIndex + ".jpg" %>' data-lightbox="gallery" data-title="<%= title %>">
                        <img src='<%= "Images/IMG_" + imageIndex + ".jpg" %>' class="gallery-img" alt='<%= title %>' />
                    </a>
                </div>
                <div class="card-content">
                    <h3 class="image-title"><%= title %></h3>
                    <p class="image-description"><%= description %></p>
                    <a href='<%= "Images/IMG_" + imageIndex + ".jpg" %>' data-lightbox="gallery-view" class="view-button">
                        <i class="fas fa-search-plus"></i> View Larger
                    </a>
                </div>
            </div>
            <% } %>
        </div>
    </div>

    <!-- Scripts -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Lightbox2/2.11.3/js/lightbox.min.js"></script>
    <script>
        $(document).ready(function () {
            // Initialize Lightbox
            lightbox.option({
                'resizeDuration': 300,
                'wrapAround': true,
                'albumLabel': "Image %1 of %2",
                'fadeDuration': 300
            });

            // Filter functionality
            $('.filter-btn').click(function () {
                // Update active button
                $('.filter-btn').removeClass('active');
                $(this).addClass('active');

                // Get filter value
                var filterValue = $(this).attr('data-filter');

                // Show/hide items based on filter
                if (filterValue === '*') {
                    $('.gallery-card, .full-width-feature').show();
                } else {
                    $('.gallery-card').hide();
                    $('.full-width-feature').hide();
                    $('.gallery-card[data-category="' + filterValue + '"]').show();
                }
            });

            // Add animation class when scrolling
            $(window).scroll(function () {
                $('.gallery-card').each(function () {
                    var position = $(this).offset().top;
                    var scroll = $(window).scrollTop();
                    var windowHeight = $(window).height();

                    if (scroll > position - windowHeight + 100) {
                        $(this).addClass('animate');
                    }
                });
            });
        });
    </script>

</asp:Content>