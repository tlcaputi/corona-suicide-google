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

# timeline.theo_timeline(
#     terms = ['suicide'],
#     names = ['suicide-test'],
#     start = '2019-10-01',
#     end = '2020-06-10',
#     timeframe_list = ['day'],
#     geo_country_list = ['US'],
#     us_states = False,
#     worldwide = False,
#     timestep_years = 1,
#     batch_size = 10,
#     outpath = "{}/input/individual".format(ROOTPATH),
#     creds = "C:/Users/tcapu/Google Drive/modules/gtrendspy/info_mark.py"
# )
#
#
#
# timeline.theo_timeline(
#     terms = ['suicide - squad'],
#     names = ['suicide'],
#     start = '2019-01-01',
#     end = '2020-06-10',
#     timeframe_list = ['day'],
#     geo_country_list = ['US'],
#     us_states = False,
#     worldwide = False,
#     timestep_years = 1,
#     batch_size = 2,
#     outpath = "{}/input".format(ROOTPATH),
#     creds = "C:/Users/tcapu/Google Drive/modules/gtrendspy/info_mark.py"
# )

# topterms.theo_timeline_top(
#         root_terms = ['commit suicide', 'how suicide', 'depression help', 'suicide help'], # a list of the root terms you're interested in
#         num_terms_per_root = 10, # how many additional terms you want per root term
#         start = '2019-01-01', # the start date
#         end = '2020-04-10', # the end date
#         timeframe_list = ['week'], # the timeframe you want
#         outpath = "{}/input/individual".format(ROOTPATH),
#         creds = "C:/Users/tcapu/Google Drive/modules/gtrendspy/info_mark.py",
#         geo_country_list = ['US'], # the region you're interested in. ONLY CHOOSE 1 or None
#         batch_size = 20,
#         timestep_years = 1,
#         get_all = True,
#         all_path = "{}/input".format(ROOTPATH)
#         )
