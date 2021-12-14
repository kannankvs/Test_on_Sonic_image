# This is a basic workflow to help you get started with GitHub Actions

name: Run the supported_devices_platforms_md.sh

# Run the script once in a minute. Github may take 15 minutes to run this even though we request once in a minute, which is OK.
on:
schedule:
    - cron:  '1 * * * *'

jobs:
  build:
    # The type of runner that the job will run on
    runs-on: ubuntu-latest

    # Steps represent a sequence of tasks that will be executed as part of the job
    steps:
      - uses: actions/checkout@v2 
        
      - name: Run the script to build a json file with details about various builds for various platforms
        run: sh ./supported_devices_platforms_md.sh
