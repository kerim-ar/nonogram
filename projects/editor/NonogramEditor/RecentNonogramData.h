#ifndef RECENTNONOGRAMDATA_H
#define RECENTNONOGRAMDATA_H

#include <QString>

class RecentNonogramData
{
public:
    RecentNonogramData(const QString & path, int time);

    QString Path() const;
    int Time() const;
private:
    int m_time; // time of the last edit
    QString m_path; // path
};

#endif // RECENTNONOGRAMDATA_H
