## Collection of scraped data on data science incubators, bootcamps, and coding schools

### Summary
* Scraped data on data science career accelerator programs
* Created structured datasets that include participants' academic background, project descriptions, and hiring company
* Compared information on program partcipants and their projects
* Discovered that these programs attract participants from Physics-related academic backgrounds who have attained at least a PhD
* Some programs offer the option to participate remotely
* Hot project topics include NLP, image classification, mapping, and recommender systems

---

### Background
In my journey to transition to a career in data science, I was interested in learning more about various data science career development programs. After completing several massive online open courses (or *MOOCs*), participating in a few Kaggle competitions, and spending countless hours doing self-directed data analyses, I felt like I needed more structure and direction. 

While researching programs, I discovered a trove of information on past participants, the projects they completed during the program, and the companies that hired them. This information was very helpful in determing which program I might apply to, and the type of project I would consider completing.

---

### Methodology
* Using python's BeautifulSoup module, I scraped data on past program participants from the sites of three programs.
* I created structured datasets from the scraped data, and did extensive data cleaning. The datasets included information on particpants' academic background, project descriptions, and hiring company.
* I analyzed information on project titles, which were often short blurbs similar to tweets. Using python's natural language toolkit (nltk) module, I stemmed and tokenized project title words. Creating word vectors of project titles allowed for comparison of similarity between projects.

---

### Interesting Findings
* Each of the programs recruits and attracts participants from Physics-related disciplines, people who have earned at least a PhD
* Some programs offer the option to participate remotely, which is helpful given the increased geographic diversity of available data science jobs.
* Many projects use NLP, image classification, mapping, and recommender systems

---

### Data sources

* [The Data Incubator](https://www.thedataincubator.com)
* [Metis](https://thisismetis.com)
* [Insight Data Science](https://www.insightdatascience.com)
