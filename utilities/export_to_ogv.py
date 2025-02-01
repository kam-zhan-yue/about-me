import os
import subprocess

def convert_all_mp4_to_ogv(input_folder, output_folder):
    # Ensure output folder exists
    os.makedirs(output_folder, exist_ok=True)

    # Get all .mp4 files in the input folder
    for filename in os.listdir(input_folder):
        if filename.endswith(".mp4"):
            input_path = os.path.join(input_folder, filename)
            output_filename = os.path.splitext(filename)[0] + ".ogv"
            output_path = os.path.join(output_folder, output_filename)

            try:
                print(f"Converting {filename} to {output_filename}...")
                command = [
                    "ffmpeg",
                    "-i", input_path,
                    "-vf", "scale=-1:720",
                    "-q:v", "6",
                    "-q:a", "6",
                    output_path
                ]
                subprocess.run(command, check=True)
                print(f"✔ Successfully converted: {filename}")
            except subprocess.CalledProcessError as e:
                print(f"❌ Error converting {filename}: {e}")

if __name__ == "__main__":
    input_folder = "/Users/kamzhanyue/Documents/personal/about-me/utilities/mp4/"
    output_folder = "ogv"

    convert_all_mp4_to_ogv(input_folder, output_folder)
    print("🎉 All files converted successfully!")
