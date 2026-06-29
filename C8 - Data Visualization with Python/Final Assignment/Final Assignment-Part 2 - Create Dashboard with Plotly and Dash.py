# =========================================================
# FINAL ASSIGNMENT PART 2
# Create Dashboard using Plotly and Dash
# =========================================================

# =========================================================
# IMPORT LIBRARIES
# =========================================================

import pandas as pd
import dash
from dash import dcc
from dash import html
from dash.dependencies import Input, Output
import plotly.express as px

# =========================================================
# LOAD DATASET
# =========================================================

data = pd.read_csv(
    'https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBMDeveloperSkillsNetwork-DV0101EN-SkillsNetwork/Data%20Files/auto_sales.csv'
)

# =========================================================
# CREATE YEAR LIST
# =========================================================

year_list = [i for i in range(1980, 2014, 1)]

# =========================================================
# CREATE DASH APPLICATION
# =========================================================

app = dash.Dash(__name__)

# =========================================================
# APPLICATION LAYOUT
# =========================================================

app.layout = html.Div([

    # =====================================================
    # DASHBOARD TITLE
    # =====================================================

    html.H1(
        "Automobile Sales Statistics Dashboard",

        style={
            'textAlign': 'center',
            'color': '#503D36',
            'font-size': 24
        }
    ),

    # =====================================================
    # DROPDOWN SECTION
    # =====================================================

    html.Div([

        # -------------------------------------------------
        # REPORT TYPE DROPDOWN
        # -------------------------------------------------

        html.Div([

            html.Label("Select Statistics:"),

            dcc.Dropdown(

                id='dropdown-statistics',

                options=[

                    {
                        'label': 'Yearly Statistics',
                        'value': 'Yearly Statistics'
                    },

                    {
                        'label': 'Recession Period Statistics',
                        'value': 'Recession Period Statistics'
                    }

                ],

                placeholder='Select a report type',

                value='Select Statistics',

                style={
                    'width': '80%',
                    'padding': '3px',
                    'font-size': '20px',
                    'text-align-last': 'center'
                }

            )

        ]),

        # -------------------------------------------------
        # YEAR DROPDOWN
        # -------------------------------------------------

        html.Div([

            html.Label("Select Year:"),

            dcc.Dropdown(

                id='select-year',

                options=[
                    {'label': i, 'value': i}
                    for i in year_list
                ],

                placeholder='Select-year',

                value=1980

            )

        ])

    ]),

    html.Br(),
    html.Br(),

    # =====================================================
    # OUTPUT CONTAINER
    # =====================================================

    html.Div(

        id='output-container',

        className='chart-grid',

        style={
            'display': 'flex',
            'flex-direction': 'column'
        }

    )

])

# =========================================================
# CALLBACK 1
# ENABLE/DISABLE YEAR DROPDOWN
# =========================================================

@app.callback(

    Output(
        component_id='select-year',
        component_property='disabled'
    ),

    Input(
        component_id='dropdown-statistics',
        component_property='value'
    )

)

def update_input_container(selected_statistics):

    if selected_statistics == 'Yearly Statistics':

        return False

    else:

        return True

# =========================================================
# CALLBACK 2
# UPDATE OUTPUT CONTAINER
# =========================================================

@app.callback(

    Output(
        component_id='output-container',
        component_property='children'
    ),

    [

        Input(
            component_id='dropdown-statistics',
            component_property='value'
        ),

        Input(
            component_id='select-year',
            component_property='value'
        )

    ]

)

def update_output_container(selected_statistics, input_year):

    # =====================================================
    # RECESSION PERIOD STATISTICS
    # =====================================================

    if selected_statistics == 'Recession Period Statistics':

        # -------------------------------------------------
        # FILTER RECESSION DATA
        # -------------------------------------------------

        recession_data = data[data['Recession'] == 1]

        # -------------------------------------------------
        # PLOT 1
        # AUTOMOBILE SALES FLUCTUATION
        # -------------------------------------------------

        yearly_rec = recession_data.groupby(
            'Year'
        )['Automobile_Sales'].mean().reset_index()

        R_chart1 = dcc.Graph(

            figure=px.line(

                yearly_rec,

                x='Year',

                y='Automobile_Sales',

                title='Average Automobile Sales Fluctuation Over Recession Period'
            )
        )

        # -------------------------------------------------
        # PLOT 2
        # AVERAGE VEHICLES SOLD BY VEHICLE TYPE
        # -------------------------------------------------

        average_sales = recession_data.groupby(
            'Vehicle_Type'
        )['Automobile_Sales'].mean().reset_index()

        R_chart2 = dcc.Graph(

            figure=px.bar(

                average_sales,

                x='Vehicle_Type',

                y='Automobile_Sales',

                title='Average Number of Vehicles Sold by Vehicle Type'
            )
        )

        # -------------------------------------------------
        # PLOT 3
        # ADVERTISEMENT EXPENDITURE SHARE
        # -------------------------------------------------

        exp_rec = recession_data.groupby(
            'Vehicle_Type'
        )['Advertising_Expenditure'].sum().reset_index()

        R_chart3 = dcc.Graph(

            figure=px.pie(

                exp_rec,

                values='Advertising_Expenditure',

                names='Vehicle_Type',

                title='Total Expenditure Share by Vehicle Type During Recessions'
            )
        )

        # -------------------------------------------------
        # PLOT 4
        # UNEMPLOYMENT EFFECT ON VEHICLE SALES
        # -------------------------------------------------

        unemp_data = recession_data.groupby(
            ['unemployment_rate', 'Vehicle_Type']
        )['Automobile_Sales'].mean().reset_index()

        R_chart4 = dcc.Graph(

            figure=px.bar(

                unemp_data,

                x='unemployment_rate',

                y='Automobile_Sales',

                color='Vehicle_Type',

                labels={
                    'unemployment_rate': 'Unemployment Rate',
                    'Automobile_Sales': 'Average Automobile Sales'
                },

                title='Effect of Unemployment Rate on Vehicle Type and Sales'
            )
        )

        # -------------------------------------------------
        # RETURN RECESSION CHARTS
        # -------------------------------------------------

        return [

            html.Div([

                html.Div(children=R_chart1),

                html.Div(children=R_chart2)

            ],

            style={'display': 'flex'}),

            html.Div([

                html.Div(children=R_chart3),

                html.Div(children=R_chart4)

            ],

            style={'display': 'flex'})

        ]

    # =====================================================
    # YEARLY STATISTICS
    # =====================================================

    elif selected_statistics == 'Yearly Statistics':

        # -------------------------------------------------
        # FILTER YEARLY DATA
        # -------------------------------------------------

        yearly_data = data[data['Year'] == int(input_year)]

        # -------------------------------------------------
        # PLOT 1
        # YEARLY AUTOMOBILE SALES
        # -------------------------------------------------

        yas = data.groupby(
            'Year'
        )['Automobile_Sales'].mean().reset_index()

        Y_chart1 = dcc.Graph(

            figure=px.line(

                yas,

                x='Year',

                y='Automobile_Sales',

                title='Yearly Automobile Sales'
            )
        )

        # -------------------------------------------------
        # PLOT 2
        # TOTAL MONTHLY AUTOMOBILE SALES
        # -------------------------------------------------

        mas = yearly_data.groupby(
            'Month'
        )['Automobile_Sales'].sum().reset_index()

        Y_chart2 = dcc.Graph(

            figure=px.line(

                mas,

                x='Month',

                y='Automobile_Sales',

                title='Total Monthly Automobile Sales'
            )
        )

        # -------------------------------------------------
        # PLOT 3
        # AVERAGE VEHICLES SOLD BY VEHICLE TYPE
        # -------------------------------------------------

        avr_vdata = yearly_data.groupby(
            'Vehicle_Type'
        )['Automobile_Sales'].mean().reset_index()

        Y_chart3 = dcc.Graph(

            figure=px.bar(

                avr_vdata,

                x='Vehicle_Type',

                y='Automobile_Sales',

                title='Average Vehicles Sold by Vehicle Type in the Year {}'.format(input_year)
            )
        )

        # -------------------------------------------------
        # PLOT 4
        # TOTAL ADVERTISEMENT EXPENDITURE
        # -------------------------------------------------

        exp_data = yearly_data.groupby(
            'Vehicle_Type'
        )['Advertising_Expenditure'].sum().reset_index()

        Y_chart4 = dcc.Graph(

            figure=px.pie(

                exp_data,

                values='Advertising_Expenditure',

                names='Vehicle_Type',

                title='Total Advertisement Expenditure for Each Vehicle'
            )
        )

        # -------------------------------------------------
        # RETURN YEARLY CHARTS
        # -------------------------------------------------

        return [

            html.Div([

                html.Div(children=Y_chart1),

                html.Div(children=Y_chart2)

            ],

            style={'display': 'flex'}),

            html.Div([

                html.Div(children=Y_chart3),

                html.Div(children=Y_chart4)

            ],

            style={'display': 'flex'})

        ]

    # =====================================================
    # DEFAULT RETURN
    # =====================================================

    else:

        return html.Div()

# =========================================================
# RUN APPLICATION
# =========================================================

if __name__ == '__main__':

    app.run(debug=True)