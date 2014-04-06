#include "RecentNonogramData.h"

RecentNonogramData::RecentNonogramData(const QString &path, int time)
    :m_path(path), m_time(time)
{
}

QString RecentNonogramData::Path() const
{
    return m_path;
}

int RecentNonogramData::Time() const
{
    return m_time;
}
