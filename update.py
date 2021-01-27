#!/usr/bin/env python3
import argparse
import glob
import logging
import pkg_resources

logging.basicConfig(level=logging.INFO, format=">>> {message}", style="{")
logger = logging.getLogger("xvm-updater")


def scrape_current_version():
    versions = []
    for version_string in glob.glob("../1.*"):
        versions.append(pkg_resources.parse_version(version_string[3:]))
    versions.sort()
    local_version = versions[-1]
    logger.info(f"Local game version: {local_version}")

if __name__ == "__main__":
    parser = argparse.ArgumentParser(
        epilog="The script downloads a version of the XVM, the runs Beyond Compare (tm) against your"
        " own config vs the downloaded XVM's config. Once comparison is done, it will replace"
        " the XVM with the downloaded one, along installing your custom sixth sense icon"
        " from the resources folder. Beyond Compare, by Scooter Software, is the world's best diff-tool.",
        description="This script is tool to help in updating your XVM config to be compatible with the latest XVM version.",
        formatter_class=argparse.ArgumentDefaultsHelpFormatter,
    )
    parser.add_argument(
        "-x",
        "--xvm",
        help="Specify the version of XVM to download. Use 'dev' as the version"
        " to instruct the script to download the development version"
        " of the XVM. Use 'scrape' as the version to instruct the script"
        " to try to deduce the correct version automatically.",
        default="scrape",
    )
    parser.add_argument(
        "-b", "--beyond-compare", help="Launch the Beyond Compare (tm) stage.", default=False, action="store_true"
    )
    parser.add_argument(
        "-s", "--sixth-sense", help="Install only the sixth sense icon.", default=False, action="store_true"
    )
    parser.add_argument(
        "-f",
        "--finalize",
        help="Only run the finalize step, i.e. replace the old XVM with the"
        " new downloaded one, and copy the sixth sense icon.",
        default=False,
        action="store_true",
    )
    args = parser.parse_args()
    if args.xvm == "scrape":
        args.xvm = scrape_current_version()
