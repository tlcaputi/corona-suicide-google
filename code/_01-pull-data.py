import re
from gtrendspy import topterms, timeline


ROOTPATH = "C:/Users/tcapu/Google Drive/PublicHealthStudies/coronasuicide"


rw_terms = [
        'suicide chat',
        'suicide is painless',
        'national suicide hotline',
        'suicide prevention chat',
        'painless suicide',
        'how to kill yourself', 'suicide hotline',
        'how to suicide',
        'suicidal ideation',
        'suicidal',
        'commit suicide',
        'suicide statistics',
        'suicide',
        'suicide hotline number',
        'suicide quotes + suicidal quotes',
        'suicide prevention',
        'suicidal thoughts',
        'how to commit suicide',
        'teen suicide',
        'suicide song + suicide songs'
        ]

rw_names = [re.sub("[+]","", x) for x in rw_terms]
rw_names = [re.sub(" ","_", x) for x in rw_names]
rw_names = [re.sub("__","_", x) for x in rw_names]

timeline.theo_timeline(
    terms = rw_terms,
    names = rw_names,
    start = '2019-10-01',
    end = '2020-06-10',
    timeframe_list = ['day'],
    geo_country_list = ['US'],
    us_states = False,
    worldwide = False,
    timestep_years = 1,
    batch_size = 3,
    outpath = "{}/input/individual".format(ROOTPATH),
    creds = "C:/Users/tcapu/Google Drive/modules/gtrendspy/info_mark.py"
)

timeline.theo_timeline(
    terms = ['suicide - squad'],
    names = ['suicide'],
    start = '2019-01-01',
    end = '2020-06-10',
    timeframe_list = ['day'],
    geo_country_list = ['US'],
    us_states = False,
    worldwide = False,
    timestep_years = 1,
    batch_size = 2,
    outpath = "{}/input".format(ROOTPATH),
    creds = "C:/Users/tcapu/Google Drive/modules/gtrendspy/info_mark.py"
)
