import sys
from PIL import Image
from collections import Counter

def get_dominant_color(image_path):
    try:
        img = Image.open(image_path)
        img = img.convert("RGB")
        img = img.resize((50, 50))  # Resize to speed up processing
        pixels = list(img.getdata())
        
        # Filter out blacks/whites if they are background
        filtered_pixels = [p for p in pixels if not (p[0] < 20 and p[1] < 20 and p[2] < 20) and not (p[0] > 240 and p[1] > 240 and p[2] > 240)]
        
        if not filtered_pixels:
            filtered_pixels = pixels

        counts = Counter(filtered_pixels)
        common = counts.most_common(5)
        print(f"Top 5 colors for {image_path}:")
        for color, count in common:
            hex_c = "#{:02x}{:02x}{:02x}".format(color[0], color[1], color[2])
            print(f"  {hex_c}: {count}")
        
        dominant = common[0][0]
        hex_color = "#{:02x}{:02x}{:02x}".format(dominant[0], dominant[1], dominant[2])
        return hex_color
    except Exception as e:
        print(f"Error processing {image_path}: {e}")
        return None

if __name__ == "__main__":
    get_dominant_color("d:/FLUTTER-APP-DEVELOPMENT/bharat-mandiram-app/user-app/assets/images/appicon.png")
    get_dominant_color("d:/FLUTTER-APP-DEVELOPMENT/bharat-mandiram-app/user-app/android/app/src/main/res/playstore-icon.png")
